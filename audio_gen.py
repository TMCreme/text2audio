"""
Audio generator
"""
import subprocess


def run_audioldm(text: str):
    """Take a string and call the audioldm"""
    result = subprocess.run(
        [f"audioldm -t '{text}'"], shell=True, capture_output=True
        )
    print(result.stdout)
    return result.stdout
