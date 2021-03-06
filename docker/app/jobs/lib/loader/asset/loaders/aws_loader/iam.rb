# frozen_string_literal: true

#
# Load IAM assets into RedisGraph
#
class AWSLoader::IAM < GraphDbLoader
  def account_summary
    node = 'AWS_IAM_ACCOUNT_SUMMARY'
    q = []

    # account_summary node
    q.push(_upsert({ node: node, id: @name }))
  end

  def password_policy
    node = 'AWS_IAM_PASSWORD_POLICY'
    q = []

    # password_policy node
    q.push(_upsert({ node: node, id: @name }))
  end

  def credential_report
    node = 'AWS_IAM_USER'
    q = []

    @data&.content&.each do |user|
      id = user.delete_field('arn')

      q.push(_merge({ node: node, id: id }))

      opts = {
        node: node,
        id: id,
        data: user
      }

      q.push(_append(opts))
    end

    q
  end
end
