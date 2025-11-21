#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/.."
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Erro: diretório não é um repositório git."; exit 1
fi

commits=(
  "chore: project metadata and npm scripts|chore: project metadata and npm scripts|package.json angular.json tsconfig.json tsconfig.app.json tsconfig.spec.json"
  "docs: README do projeto|docs: README do projeto|README.md"
  "chore: add .env example and ignore .env|chore: add .env example and ignore .env|.gitignore .env-example"
  "feat(ssr): add app entry points and global index/styles|feat(ssr): add app entry points and global index/styles|src/main.ts src/main.server.ts src/server.ts src/index.html src/styles.css"
  "feat(app): app shell, routes and config|feat(app): app shell, routes and config|src/app/app.ts src/app/app.html src/app/app.css src/app/app.routes.ts src/app/app.routes.server.ts src/app/app.config.ts src/app/app.config.server.ts src/app/app.spec.ts"
  "chore(env): add environment file with default API URL|chore(env): add environment file with default API URL|src/environments/environment.ts"
  "feat(shared): add confirmation modal component|feat(shared): add confirmation modal component|src/app/shared/components/confirmation-modal/confirmation-modal.ts src/app/shared/components/confirmation-modal/confirmation-modal.html src/app/shared/components/confirmation-modal/confirmation-modal.css src/app/shared/components/confirmation-modal/confirmation-modal.spec.ts"
  "feat(pipes): add CPF and telephone pipes with tests|feat(pipes): add CPF and telephone pipes with tests|src/app/pipes/format-cpf-pipe.ts src/app/pipes/format-cpf-pipe.spec.ts src/app/pipes/format-telefone-pipe.ts src/app/pipes/format-telefone-pipe.spec.ts"
  "feat(auth): add AuthGuard and tests|feat(auth): add AuthGuard and tests|src/app/guards/auth-guard.ts src/app/guards/auth-guard.spec.ts"
  "feat(auth): add AuthInterceptor and tests|feat(auth): add AuthInterceptor and tests|src/app/interceptors/auth-interceptor.ts src/app/interceptors/auth-interceptor.spec.ts"
  "feat(models): add domain models and DTOs|feat(models): add domain models and DTOs|src/app/models/abastecimento.model.ts src/app/models/agendamento.model.ts src/app/models/manutencao.model.ts src/app/models/motorista.model.ts src/app/models/ocorrencia.model.ts src/app/models/veiculo.model.ts src/app/dto/agendamento-request.model.ts src/app/dto/iniciar-viagem-request.model.ts src/app/dto/finalizar-viagem-request.model.ts"
  "feat(auth-service): add Auth service and tests|feat(auth-service): add Auth service and tests|src/app/services/auth.ts src/app/services/auth.spec.ts"
  "feat(services): add confirmation service and tests|feat(services): add confirmation service and tests|src/app/services/confirmation.ts src/app/services/confirmation.spec.ts"
  "feat(services): add abastecimento service and tests|feat(services): add abastecimento service and tests|src/app/services/abastecimento.ts src/app/services/abastecimento.spec.ts"
  "feat(services): add agendamento service and tests|feat(services): add agendamento service and tests|src/app/services/agendamento.ts src/app/services/agendamento.spec.ts"
  "feat(services): add manutencao service and tests|feat(services): add manutencao service and tests|src/app/services/manutencao.ts src/app/services/manutencao.spec.ts"
  "feat(services): add motorista service and tests|feat(services): add motorista service and tests|src/app/services/motorista.ts src/app/services/motorista.spec.ts"
  "feat(services): add veiculo service and tests|feat(services): add veiculo service and tests|src/app/services/veiculo.ts src/app/services/veiculo.spec.ts"
  "feat(services): add ocorrencia service and tests|feat(services): add ocorrencia service and tests|src/app/services/ocorrencia.ts src/app/services/ocorrencia.spec.ts"
  "feat(services): add via-cep service and tests|feat(services): add via-cep service and tests|src/app/services/via-cep.ts src/app/services/via-cep.spec.ts"
  "feat(pages): add login page and tests|feat(pages): add login page and tests|src/app/pages/login/login.ts src/app/pages/login/login.html src/app/pages/login/login.css src/app/pages/login/login.spec.ts"
  "feat(pages): add admin dashboard and tests|feat(pages): add admin dashboard and tests|src/app/pages/admin-dashboard/admin-dashboard.ts src/app/pages/admin-dashboard/admin-dashboard.html src/app/pages/admin-dashboard/admin-dashboard.css src/app/pages/admin-dashboard/admin-dashboard.spec.ts"
  "feat(pages): add motorista dashboard, details and form with tests|feat(pages): add motorista dashboard, details and form with tests|src/app/pages/motorista-dashboard/motorista-dashboard.ts src/app/pages/motorista-dashboard/motorista-dashboard.html src/app/pages/motorista-dashboard/motorista-dashboard.css src/app/pages/motorista-dashboard/motorista-dashboard.spec.ts src/app/pages/motorista-details/motorista-details.ts src/app/pages/motorista-details/motorista-details.html src/app/pages/motorista-details/motorista-details.css src/app/pages/motorista-details/motorista-details.spec.ts src/app/pages/motorista-form/motorista-form.ts src/app/pages/motorista-form/motorista-form.html src/app/pages/motorista-form/motorista-form.css src/app/pages/motorista-form/motorista-form.spec.ts"
  "feat(pages): add vehicle forms, details and maintenances with tests|feat(pages): add vehicle forms, details and maintenances with tests|src/app/pages/vehicle-form/vehicle-form.ts src/app/pages/vehicle-form/vehicle-form.html src/app/pages/vehicle-form/vehicle-form.css src/app/pages/vehicle-form/vehicle-form.spec.ts src/app/pages/veiculo-details/veiculo-details.ts src/app/pages/veiculo-details/veiculo-details.html src/app/pages/veiculo-details/veiculo-details.css src/app/pages/veiculo-details/veiculo-details.spec.ts src/app/pages/veiculo-manutencoes/veiculo-manutencoes.ts src/app/pages/veiculo-manutencoes/veiculo-manutencoes.html src/app/pages/veiculo-manutencoes/veiculo-manutencoes.css src/app/pages/veiculo-manutencoes/veiculo-manutencoes.spec.ts"
  "feat(pages): add abastecimento form and tests|feat(pages): add abastecimento form and tests|src/app/pages/abastecimento-form/abastecimento-form.ts src/app/pages/abastecimento-form/abastecimento-form.html src/app/pages/abastecimento-form/abastecimento-form.css src/app/pages/abastecimento-form/abastecimento-form.spec.ts"
  "feat(pages): add manutencao form and tests|feat(pages): add manutencao form and tests|src/app/pages/manutencao-form/manutencao-form.ts src/app/pages/manutencao-form/manutencao-form.html src/app/pages/manutencao-form/manutencao-form.css src/app/pages/manutencao-form/manutencao-form.spec.ts"
  "feat(pages): add agendamento form and details with tests|feat(pages): add agendamento form and details with tests|src/app/pages/agendamento-form/agendamento-form.ts src/app/pages/agendamento-form/agendamento-form.html src/app/pages/agendamento-form/agendamento-form.css src/app/pages/agendamento-form/agendamento-form.spec.ts src/app/pages/agendamento-details/agendamento-details.ts src/app/pages/agendamento-details/agendamento-details.html src/app/pages/agendamento-details/agendamento-details.css src/app/pages/agendamento-details/agendamento-details.spec.ts"
  "feat(pages): add ocorrencia form and tests|feat(pages): add ocorrencia form and tests|src/app/pages/ocorrencia-form/ocorrencia-form.ts src/app/pages/ocorrencia-form/ocorrencia-form.html src/app/pages/ocorrencia-form/ocorrencia-form.css src/app/pages/ocorrencia-form/ocorrencia-form.spec.ts"
  "chore: misc app css and basic tests|chore: misc app css and basic tests|src/app/app.css src/app/app.spec.ts"
)

created=()
skipped=()

for entry in "${commits[@]}"; do
  IFS='|' read -r title msg files <<< "$entry"
  # build list of existing files
  to_add=()
  for f in $files; do
    if [ -e "$f" ]; then
      to_add+=("$f")
    fi
  done
  if [ ${#to_add[@]} -gt 0 ]; then
    git add "${to_add[@]}"
    if git commit -m "$title" -m "$msg"; then
      echo "Committed: $title"
      created+=("$title")
    else
      echo "Commit failed for: $title" >&2
      skipped+=("$title (commit failed)")
    fi
  else
    echo "Skipping (no files): $title"
    skipped+=("$title (no files)")
  fi
done

echo "\nSummary:\n"
echo "Created commits:"; printf "%s\n" "${created[@]}"
echo "\nSkipped:"; printf "%s\n" "${skipped[@]}"
