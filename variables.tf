variable "network" {
  type = object({
    name = string
    desc = string
  })
}

variable "member" {
  type = object({
    name = string
    id = string
    desc = string
  })
}

variable "token" {
  type = string
}
