echo "what is application name?"

read application_name

applications_folder="./applications"

export APPLICATIONS_FOLDER="$applications_folder"
if [ -d "$APPLICATIONS_FOLDER" ]; then
  mkdir $applications_folder/$application_name
else
  mkdir $applications_folder
  mkdir $applications_folder/$application_name
fi

yarn
wait

cd $applications_folder/$application_name

yarn init -y
wait

yarn add typescript @types/node tsconfig-paths ts-node ts-node-dev @types/express -D
wait

yarn add express
wait

mkdir src

touch src/server.ts

touch tsconfig.json

printf '
  {
  "compilerOptions": {
    "module": "CommonJS",
    "allowJs": true,
    "target": "ES6",
    "outDir": "./dist",
    "esModuleInterop": true,
    "baseUrl": "./src",
    "paths": {
      "@/*":["./*"],
    },  
  },
  "exclude": [
    "node_modules"
  ]
}
' >> tsconfig.json

cd src

printf 'import express,{Request, Response} from "express"\n
const app = express()\n

app.get("/", (req:Request, res:Response) => {


  return res.json({ok:true})
})

app.listen(3333, () => console.log("App Running on 3333"))' >> server.ts

cd ..
cd ..
cd ..

# On Root Folder

echo "exporting applicattion name"

export APPLICATION_NAME="$application_name"

node "./script.js"
wait

cd $applications_folder/$application_name
yarn dev