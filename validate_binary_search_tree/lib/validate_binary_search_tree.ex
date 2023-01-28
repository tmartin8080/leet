defmodule ValidateBinarySearchTree do
  @moduledoc """
  Given the root of a binary tree, determine if it is a valid binary search tree (BST).

  A valid BST is defined as follows:

  1. The left subtree of a node contains only nodes with keys less than the node's key.
  2. The right subtree of a node contains only nodes with keys greater than the node's key.
  3. Both the left and right subtrees must also be binary search trees.

  ## Constraints:

  1. The number of nodes in the tree is in the range [1, 10^4].
  2. -2^31 <= Node.val <= 2^31 - 1

  """
  @spec is_valid_bst(root :: TreeNode.t() | nil) :: boolean
  def is_valid_bst(root) do
    stack = in_order(root, [])
    result = Enum.reduce_while(stack, :root, &validate/2)
    is_integer(result)
  end

  defp in_order(nil, stack), do: stack

  defp in_order(node, stack) do
    stack = in_order(node.left, stack)
    stack = [node.val | stack]
    in_order(node.right, stack)
  end

  defp validate(:root, curr) do
    {:cont, curr}
  end

  defp validate(curr, prev) do
    if curr >= prev do
      {:halt, :invalid_bst}
    else
      {:cont, curr}
    end
  end
end
