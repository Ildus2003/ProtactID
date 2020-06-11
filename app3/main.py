# -*- coding: utf-8 -*-
"""
Created on Wed May 13 17:05:27 2020

@author: Ильдус Яруллин
"""



from kivymd.app import MDApp
from kivy.uix.floatlayout import FloatLayout
from kivy.uix.boxlayout import BoxLayout
from kivy.core.window import Window
from kivy.uix.screenmanager import ScreenManager, Screen

from kivymd.app import MDApp
from kivymd.theming import ThemableBehavior
from kivymd.uix.list import OneLineListItem, MDList
from kivy.properties import StringProperty


#Window.size=[240,480]
Window.clearcolor = (0, 0.67, 1, 1) #00abff


class ContentNavigationDrawer(BoxLayout):
    pass



class ItemDrawer(OneLineListItem):
    icon = StringProperty()


class DrawerList(ThemableBehavior, MDList):
    def set_color_item(self, instance_item):
        """Called when tap on a menu item."""

        # Set the color of the icon and text for the menu item.
        for item in self.children:
            if item.text_color == self.theme_cls.primary_color:
                item.text_color = self.theme_cls.text_color
                break
        instance_item.text_color = self.theme_cls.primary_color

class MainContainer(Screen):        
	pass

class Container(Screen):
	def __new__(secondContainer, *args, **kwargs):
		return super().__new__(secondContainer)


	def Start_(self):
		App.root.current='menu'
		
		icons_item = {"0": "Пользователи",
		"1": "Яруллин Ильдус",
		"2": "Контакты"}
		for icon_name in icons_item.keys():
			App.root.current_screen.content_drawer.ids.md_list.add_widget(ItemDrawer(text=icons_item[icon_name]))	

	def change_image(self,LR):
		if LR=='R':
			self.img_start.load_next()

			if self.img_start.index+1==2:
				self.arrow_rigth.size_hint=0,0.05
			else:
				self.arrow_left.size_hint=0.05,0.05
				self.arrow_rigth.size_hint=0.05,0.05
		elif LR=='L':
			self.img_start.load_previous()
			if self.img_start.index-1==0:
				self.arrow_left.size_hint=0,0.05
			else:
				self.arrow_left.size_hint=0.05,0.05
				self.arrow_rigth.size_hint=0.05,0.05
class sm(ScreenManager):	
	pass

class MyApp(MDApp):
	def build(self):
		return sm()

if __name__ == '__main__':
	App=MyApp()
	App.run()