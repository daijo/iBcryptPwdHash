iBcryptPwdHash
==============

The iOS app version of [BcryptPwdHash](https://github.com/daijo/BcryptPwdHash) a modified version of the [Stanford PwdHash](https://www.pwdhash.com/).

The original PwdHash generates theft-resistant passwords but uses a weak hashing method. This is the same thing but using the stronger and slower (which is good) Bcrypt hashing. It requires you to keep a randomly generated salt to retrive your hashed password later. The salt makes it harder for an attacker to use rainbow tables.

Usage
-----

Enter the website address you will use the hashed password for or use a previously enter address via the bookmarks in the toolbar.

Select number of rounds to use by pressing the cogwheel toolbar button. More rounds will be slower and harder to bruteforce attack. Default is twelve rounds.

When using the first time leave the salt field empty to generate a new random salt or copy in a previously used salt. The generated salt is fixed to a number of rounds. The salt field can be emptied to generate a new salt at any time. The app will remember your salts (per rounds) but it might be a good idea to save it somewhere else.

Enter the password to hash and press 'Create'. Wait until the password has been created then paste the crated password into the websites password field. Pressing the clear button in the password filed will clear the generated password from the screen and clipboard.

Credits
-------

The basis for the project is [Stanford PwdHash](https://www.pwdhash.com/).

The project use BCrypt from [JFCommon](https://github.com/jayfuerstenberg/JFCommon).


