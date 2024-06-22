import { InjectionToken } from "@angular/core";

type ImageType = { id: string; url: string; title: string };
export const ImageToken = new InjectionToken<ImageType>("ImageToken");

const flavors = [
  {
    id: "photo1",
    url: "~/assets/angular.png",
    title: "Angular",
  },
  {
    id: "photo2",
    url: "~/assets/react.png",
    title: "React",
  },
  {
    id: "photo3",
    url: "~/assets/solid.png",
    title: "Solid",
  },
  {
    id: "photo4",
    url: "~/assets/svelte.png",
    title: "Svelte",
  },
  {
    id: "photo5",
    url: "~/assets/vue.png",
    title: "Vue",
  },
];

const teams = [
  {
    id: "photo1",
    url: "~/assets/team-angular.png",
    title: "Angular",
  },
  {
    id: "photo2",
    url: "~/assets/team-react.png",
    title: "React",
  },
  {
    id: "photo3",
    url: "~/assets/team-solid.png",
    title: "Solid",
  },
  {
    id: "photo4",
    url: "~/assets/team-svelte.png",
    title: "Svelte",
  },
  {
    id: "photo5",
    url: "~/assets/team-vue.png",
    title: "Vue",
  },
];

const plants = [
  {
    id: "photo1",
    url: "res://Fish",
    title: "Fish",
  },
  {
    id: "photo2",
    url: "res://palm_tree",
    title: "Palm Tree",
  },
  {
    id: "photo3",
    url: "res://Succulent",
    title: "Succulent",
  },
  {
    id: "photo4",
    url: "res://Lily Pads",
    title: "Lily Pads",
  },
];

export const data: {
  photos: Array<ImageType>;
  cornerRadius?: number;
  contentMargins?: number;
  xOffset?: number;
  titleXOffset?: number;
  spacing?: number;
  showScrollIndicator?: boolean;
} = {
  xOffset: -200,
  titleXOffset: 100,
  cornerRadius: 45,
  contentMargins: 32,
  spacing: 16,
  showScrollIndicator: false,
  photos: plants,
};
