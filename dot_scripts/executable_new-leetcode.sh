#!/bin/bash

# Prompt the user for a LeetCode problem URL
read -p "Enter a LeetCode problem URL: " url

# Extract the problem name from the URL
readonly problem_name=$(echo $url | sed -n 's#.*/problems/\([^/]*\)/.*#\1#p')
readonly git_url=https://github.com/leavism-leetcode/$problem_name

# Check if the repository exists
readonly response=$(curl --write-out '%{http_code}' --silent --output /dev/null $git_url)
if [ $response -eq 200 ]; then
	cd ~/repositories
	if [ -d $problem_name ]; then
		cd $problem_name
		code .
	else
		git clone https://github.com/leavism-leetcode/$problem_name.git && cd $problem_name
		code .
	fi
else
	# Create a new directory for potential languages to use for the problem
	echo $problem_name
	mkdir -p ~/repositories/$problem_name && cd "$_"
	readonly projectRoot=~/repositories/$problem_name

	mkdir python
	mkdir rust
	mkdir typescript

	# Initialize a new Git repository
	# git init

	echo '# Development files
dist/
node_modules/

# IDE
.idea/

# Log files
*.log

# Build files
target/

# Etc
datetime.txt
.DS_Store
' >.gitignore

	# ======================
	# Set up for typescript
	cd $projectRoot/typescript

	# Initialize a new Node.js project with npm
	npm init -y

	# Install TypeScript and tsc-watch as dev dependencies
	npm install --save-dev typescript tsc-watch
	npm pkg set scripts.dev="tsc-watch --onSuccess \"node dist/index.js\""

	# Create a basic src/index.ts file
	mkdir src
	echo 'console.log("Hello, world!");' >src/index.ts

	# Create a basic tsconfig.json file for TypeScript
	echo '{
    "compilerOptions": {
      /* Language and Environment */
      "rootDir": "src",
      "outDir": "dist",
      "target": "es2021",                                  /* Set the JavaScript language version for emitted JavaScript and include compatible library declarations. */

      /* Modules */:
      "module": "commonjs",                                /* Specify what module code is generated. */
      "esModuleInterop": true,                             /* Emit additional JavaScript to ease support for importing CommonJS modules. This enables 'allowSyntheticDefaultImports' for type compatibility. */
      "forceConsistentCasingInFileNames": true,            /* Ensure that casing is correct in imports. */

      /* Type Checking */
      "strict": true,                                      /* Enable all strict type-checking options. */
      "skipLibCheck": true                                 /* Skip type checking all .d.ts files. */
    }
  }
  ' >tsconfig.json
	# ======================
	# Set up for python
	cd $projectRoot/python
	echo '# Copy/paste template from LeetCode below


# After copy/pasting the template from LeetCode, uncomment the following to start testing.
# solution = Solution()
' >solution.py

	# ======================
	# Commit all the set up files
	# cd $projectRoot
	# git branch -m master main
	# git add .gitignore python/ typescript/ rust/
	# git commit -m "Initial commit"

	# gh repo create --private --source=. --push leavism-leetcode/$problem_name

	# Output success message
	echo "LeetCode environment has been set up."

	nvim .
fi
