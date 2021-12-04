const dotenv = require("dotenv");
const fs = require("fs/promises");

dotenv.config();

const { APPLICATION_NAME, APPLICATIONS_FOLDER } = process.env;

const packageJsonPath = `${APPLICATIONS_FOLDER}/${APPLICATION_NAME}/package.json`;

async function readFile() {
  const json = require(packageJsonPath);

  const devScript = "ts-node-dev -r tsconfig-paths/register src/server.ts";

  const newJson = {
    ...json,
    scripts: {
      dev: devScript,
    },
  };

  await fs.writeFile(packageJsonPath, JSON.stringify(newJson, null, 2));
}

try {
  readFile();
} catch (err) {
  console.log("ERROR READING FILE =>", err);
}
