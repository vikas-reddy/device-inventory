module PramatiLdap
  def self.authenticate(username, password)
    @ldap = Net::LDAP.new(
      host: 'ldap.pramati.com',
      auth: {
        method: :simple,
        username: "uid=#{username},ou=Employees,dc=pramati,dc=com",
        password: password
      }
    )
    @ldap.bind
  end

  def load_details(username)
  end
end
