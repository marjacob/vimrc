#!/usr/bin/env python3
import argparse
import os
import re
import subprocess
import sys


def basename(file):
    return os.path.basename(os.path.normpath(file))


def git_modified_files(file):
    command = ["git", "ls-files", "--modified", file]

    try:
        return subprocess.check_output(command).decode().split('\n')
    except (subprocess.CalledProcessError, UnicodeError):
        return None

    return None


def git_submodule_hash(file):
    command = ["git", "submodule", "status", "--", file]
    regex = r"^(?:\+|\s)" \
            r"(?P<commit>[0-9A-Fa-f]+)\s" \
            r"(?P<file>.+)\s\(" \
            r"(?P<tag>.+)\)$"

    try:
        subject = subprocess.check_output(command).decode()
    except (subprocess.CalledProcessError, UnicodeError):
        return None

    match = re.search(regex, subject)

    if match:
        return match.group("commit")

    return None


def git_owner(file):
    command = ["git", "-C", file, "remote", "get-url", "origin"]
    regex = r"^(?:git@|https?://).+(?::|/)" \
            r"(?P<user>.+)/" \
            r"(?P<name>.+)(?:\.git)?$"

    try:
        subject = subprocess.check_output(command).decode()
    except (subprocess.CalledProcessError, UnicodeError):
        return None

    match = re.search(regex, subject)

    if match:
        return match.group("user")

    return None


def git_commit(file, message):
    command = ["git", "commit", file, "-m", message]

    try:
        subprocess.check_output(command)
    except subprocess.CalledProcessError:
        return False

    return True


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("-t",
                        "--test",
                        help="dry run without creating commits",
                        action="store_true")
    args = parser.parse_args()

    for submodule in git_modified_files("pack/"):
        if submodule:
            commit = git_submodule_hash(submodule)
            name = basename(submodule)
            owner = git_owner(submodule)

            if not (commit and name and owner):
                if args.test:
                    print("SUBMODULE {{commit: {},\n" \
                            "             name: {},\n " \
                            "           owner: {},\n " \
                            "            path: {}}}"
                            .format(commit, name, owner, submodule))

                continue

            if args.test:
                print("Would create commit:", end =" ")

            message = "Update {}/{}@{}".format(owner, name, commit[:7])

            if not args.test:
                if git_commit(submodule, message):
                    print(message)
            else:
                print(message)

    return 0


if __name__ == "__main__":
    sys.exit(main())
