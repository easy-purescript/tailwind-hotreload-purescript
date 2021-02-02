module Main where

import Prelude
import Effect (Effect)
import Effect.Aff.Class (class MonadAff)
import Halogen as H
import Halogen.Aff as HA
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP
import Halogen.VDom.Driver (runUI)

type State
  = {}

data Action
  = NoOp

component :: forall q i o m. MonadAff m => H.Component HH.HTML q i o m
component =
  H.mkComponent
    { initialState
    , render
    , eval: H.mkEval $ H.defaultEval { handleAction = handleAction }
    }

initialState :: forall i. i -> State
initialState _ = {}

render :: forall m. State -> H.ComponentHTML Action () m
render state =
  -- NOTE: https://tailwindui.com/components/marketing/sections/cta-sections#component-90c79fbd0596cc4e601da985ca825994
  HH.div [ cls "bg-gray-50" ]
    [ HH.div [ cls "max-w-7xl mx-auto py-12 px-4 sm:px-6 lg:py-16 lg:px-8 lg:flex lg:items-center lg:justify-between" ]
        [ HH.h2 [ cls "text-3xl font-extrabold tracking-tight text-gray-900 sm:text-4xl" ]
            [ HH.span [ cls "block" ]
                [ HH.text "Ready to dive in?" ]
            , HH.span [ cls "block text-indigo-600" ]
                [ HH.text "Start your free trial today." ]
            ]
        , HH.div [ cls "mt-8 flex lg:mt-0 lg:flex-shrink-0" ]
            [ HH.div [ cls "inline-flex rounded-md shadow" ]
                [ HH.a [ HP.href "#", cls "inline-flex items-center justify-center px-5 py-3 border border-transparent text-base font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700" ]
                    [ HH.text "Get started" ]
                ]
            , HH.div [ cls "ml-3 inline-flex rounded-md shadow" ]
                [ HH.a [ HP.href "#", cls "inline-flex items-center justify-center px-5 py-3 border border-transparent text-base font-medium rounded-md text-indigo-600 bg-white hover:bg-indigo-50" ]
                    [ HH.text "Learn more" ]
                ]
            ]
        ]
    ]
  where
  cls :: forall r i. String -> HH.IProp ( class :: String | r ) i
  cls = HP.class_ <<< H.ClassName

handleAction ∷ forall o m. MonadAff m => Action → H.HalogenM State Action () o m Unit
handleAction = case _ of
  NoOp -> pure unit

main :: Effect Unit
main =
  HA.runHalogenAff do
    body <- HA.awaitBody
    runUI component unit body
