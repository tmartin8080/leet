defmodule TreeNode do
  @type t :: %__MODULE__{
          val: integer,
          left: TreeNode.t() | nil,
          right: TreeNode.t() | nil
        }
  defstruct val: 0, left: nil, right: nil
end

defmodule BST do
  @moduledoc """
  Given the root of a binary tree, determine if it is a valid binary search tree (BST).

  A valid BST is defined as follows:

  1. The left subtree of a node contains only nodes with keys less than the node's key.
  2. The right subtree of a node contains only nodes with keys greater than the node's key.
  3. Both the left and right subtrees must also be binary search trees.

  ## Constraints:

  1. The number of nodes in the tree is in the range [1, 104].
  2. -2^31 <= Node.val <= 2^31 - 1

  """
  @min :math.pow(-2, 31)
  @max :math.pow(2, 31) - 1

  @spec is_valid_bst(root :: TreeNode.t() | nil) :: boolean
  def is_valid_bst(root) do
    validate(root, @min, @max)
  end

  # Empty trees are valid BSTs.
  defp validate(nil, _low, _high), do: true

  # The current node's value must be between low and high.
  defp validate(%{val: val}, low, high) when val <= low or val >= high, do: false

  # The left and right subtree must also be valid.
  defp validate(node, low, high) do
    validate(node.right, node.val, high) and validate(node.left, low, node.val)
  end
end
