data {
  int<lower=0> N; // individuals
  vector[N] y; // vector of observations
  vector<lower=0, upper=1>[N] x1; // (1 - g/2)
  vector<lower=0, upper=1>[N] x2; // (g/2)
}
parameters {
  real b0; // intercept
  real b1; // coefficient of genotype
  real<lower=0> sigma2;
}
model {
  vector[N] r_mu;
  vector[N] mu;
  r_mu = x1 + exp(2 * b1) * x2;
  mu = b0 + log(r_mu);
  target += normal_lpdf(y | mu, sqrt(sigma2)); // likelihood model
}
