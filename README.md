[![license](https://img.shields.io/github/license/mashape/apistatus.svg)]()

# Дипломный проект EPAM Russia



## 🛢 DataBase [PostgreSQL](https://www.postgresql.org)
* [x] Запись апдейта данных в БД



## 🔩 Backend ([Python](https://www.python.org)/[Django](https://docs.djangoproject.com/en/4.0/))
* [x] Полный вывод данных
* [ ] Настройка ввывод данных с фильтром по выбранным странам
* [ ] Настройка вывода данных с фильтром по выбранной дате
---
## 🖥 Frontend ([JS](https://www.javascript.com)/[Vue.js](https://vuejs.org))
* [ ] Полный вывод данных из БД
* [ ] Таблица по странам
* [ ] Возможность сортировки данных
* [ ] Возможность сортировки данных
---
## 🎞 CI/CD
*  [ ] Начать настраивать пайплайн
*  [ ] Начать настраивать пайплайн
---
## [Docker](https://www.docker.com)

---

## ⛅️ Облака [AWS](https://aws.amazon.com/)

---

## 📍 Task:

Using API [covidtracker.bsg.ox.ac.uk](https://covidtracker.bsg.ox.ac.uk/about-api) get all data about “Country data for a specific day" for current year and 10 any countries and store it into your DB: date_value, country_code, confirmed, deaths, stringency_actual, stringency. Output the data by date (the date is set) in form of a table and sort them by deaths in ascending order




<!-- --- -->



| Criteria  |  Reqiurements  |  Related Module |
| ------------ | ------------ | ------------ |
| SCM  |  Application sources should be placed in Git repository. Branching strategy should be explained. |  Git |
|  Tests |  CI pipeline may contain unit tests, smoke tests, linter check.  |  CI/CD |
|  Quality gate |  CI/CD pipeline should use some quality/vulnerability control tool like a Sonar or Anchore. |  CI/CD |
|  IaC |  CI/CI and runtime infrastructure should be described as a code using Terraform, CloudFormation, or any similar tool. On the demonstration deployment procedure should be shown. |  Cloud, Terraform, Ansible |
|  Orchestration |  All non cloud-native tools should be spinned up inside a K8S/OpenShift cluster inside a cloud. Application runtime environments should be inside the cluster too. |  Kubernetes |
|  Logging |  Infrastructure should have centralized log collection/display system. Logs of the application components and infra components should be collected. |  Monitoring and Logging |
|  Monitoring |  Infrastructure should have centralized metric collection/display system. Metrics of the application components and infra components should be collected. |  Monitoring and Logging |
|  Runtime/Deployment |  Runtime infrastructure should have production and non production environments.  Deploy/release strategy should be explained. |  CI/CD |
|  Scalability/redundancy |  Scalability should be provided and demonstrated |  Kubernetes |
|  Cloud and Cost efficiency |  Cloud resources and services must be used for the task. Report about the Cloud resource usage and the cost must be provided in the presentation. It should be efficient (minimal) – in accordance to the solving tasks. You can choose any cloud provider taking into account possible extra costs for the resources.  |  Cloud |
