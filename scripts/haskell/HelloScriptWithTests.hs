#!/usr/bin/env cached-nix-shell
#! nix-shell --pure
#! nix-shell -p "ghc.withPackages (ps: with ps; [hspec hspec-contrib])"
#! nix-shell -i runghc
#! nix-shell -I nixpkgs=https://nixos.org/channels/nixos-24.05/nixexprs.tar.xz

import Test.Hspec
import Test.QuickCheck
import Control.Exception (evaluate)

main :: IO ()
main = hspec $ do
  describe "Prelude.head" $ do
    it "returns the first element of a list" $ do
      head [23 ..] `shouldBe` (23 :: Int)

    it "returns the first element of an *arbitrary* list" $
      property $ \x xs -> head (x:xs) == (x :: Int)

    it "throws an exception if used with an empty list" $ do
      evaluate (head []) `shouldThrow` anyException
