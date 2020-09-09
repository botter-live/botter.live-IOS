//
//  LocalStrings.swift
//  Botter
//
//  Created by Nora on 8/11/20.
//  Copyright © 2020 BlueCrunch. All rights reserved.
//

import Foundation
import UIKit

class LocalStrings {
    static var shared = LocalStrings()
    
    var stringDict = [
        "Hey there 👋" : "مرحبا 👋" ,
        "We’re here to answer your questions about Company. Ask us anything!"  : "نحن هنا للرد ع استفساراتك عن الشركة. اسال ما تشاء!",
        "Yes" : "نعم" ,
        "No" : "لا",
        "back in 3h":"Back in 3h",
        "Write a replay":"اكتب رساله",
        "We Run on Botter" : "We Run on Botter",
        "We Run on ":"We Run on ",
        "available":"متاح",
        "online":"متصل",
        "Online":"متصل",
        "Start a conversation" : "بدأ المحادثه",
        "New conversation " : "محادثه جديد",
        "zero_duration" : "0:00",
        "Botter" :"Botter",
        "Sorry. It looks like there was an issue with your internet connection. Please check your connection and try again:" : " عفوا يبدو ان لديك مشكله اتصال بالانترنت ، برجاء التحقق من الاتصال واعاده المحاوله" ,
        "Failed to send the message" : "تعذر ارسال الرساله اعد المحاوله",
        "Booking Number" : " رقم الحجز",
        "passengers":"الركاب",
        "Flight Status" : "حاله الرحله",
        "Flight" : "رحله",
        "Departs" : "مغادره",
        "Arrives" : "وصول",
        "Order Receipt" : "تفاصيل الطلب",
        "Paid with" : "طريقه الدفع",
        "Ship to" : "العنوان",
        "Total" : "الاجمالي",
        "Qty." : "الكميه",
        "More" : "المزيد",
        "Done" : "موافق",
        "Items" : "المنتجات",
        "Ordered on" : "تاريخ الطلب",
        "summary" : "ملخص الطلب",
        "'s Order\n" : "الطلب الخاص ب ",
        "Subtotal" : "التكلفه",
        "Delivery" : "التوصيل",
        "Estimates tax" : "ضريبه مضافه",
        "Find an answer yourself" : "ابحث عن اجابه لسؤالك",
        "Search results for" : "نتائج البحث",
        "DD/MM/YYYY" : "يوم/شهر/سنه",
        "hh:mm": "سس:دد",
        "Help Center" : "مركز المساعده",
        "Updated over" : "رفع بواسطه",
        "See more results" : "المزيد",
        "Close chat" : "المزيد",
        "Are you sure, you want to close the chat?" : "هل انت متأكد من مغادره المحادثه؟",
        "Gallery": "معرض الصور",
        "Camera": "الكاميرا",
        "File" : "ارفاق ملف",
        "Sending attachment…" : "جار ارفاق الملف…" ,
        "Try another search item" :  "جرب البحث عن شئ اخر",
        "No Results for " : " لا يوجد نتائج ل",
        "Pick Your Date" : "اختر التاريخ" ,
        "Perfect day for you?" : "اختر اليوم المناسب لك"  ,
        "Cancel" : "الغاء" ,
        "Open Settings" : "الاعدادات" ,
        "Gallery access is necessary to pick your Media" : "السماح بالدخول للمعرض ضروري لاختيار الصور" ,
        "Can't find photo Library" : "معرض الصور غير متاح" ,
        "This device doesn't have photo Library" : "الهاتف لا يحتوي علي معرض" ,
        "OK" : "حسناً" ,
        "Can't find camera" : "الكاميرا غير متاحة" ,
        "This device doesn't have camera" : "الهاتف لا يحتوي علي كاميرا" ,
        "Camera access is necessary to capture your Media" : "السماح باستخدام الكاميرا ضروري لالتقاط الصور" ,
        "Something went wrong" : "حدث خطأ ما",
        "Updated over " : "تم التعديل ب " ,
        "No result for" : "لا يوجد نتائج ل " ,
        "Answer is required" : "ادخل اجابة" ,
        "     New conversation " : "   بدأ المحادثة" ,
        "Write something here …" : "اكتب شيئاً..." ,
        "Will come back later" : "سأعود لاحقاً" ,
        "End Session" : "انهى المحادثة" ,
        "Last conversation" : "اخر محادثة" ,
        "    Continue conversation " : "  اكمل المحادثة",
        "Agent" : "العامل" ,
        "Bot" : "المساعد الذكى" ,
        "You" : "انت" ,
        "Attachment" : "ملف مرفق" ,
        "Continue the conversation" : "اكمل المحادثة" ,
//        "Done" : "تم"
    ]
}
//class bLocalizedCollection : {
//    override var flipsHorizontallyInOppositeLayoutDirection: Bool{
//        return BotterSettingsManager.language == .arabic
//    }
//}
extension UICollectionViewFlowLayout{
    //    open override var flipsHorizontallyInOppositeLayoutDirection: Bool{
    //        let windows = UIApplication.shared.windows
    //        if let floatingWindow = windows.last(where:  { (window) -> Bool in
    //            window is FloatingButtonWindow
    //        }){
    //            if let currentVC = (floatingWindow as? FloatingButtonWindow)?.b_visibleViewController{
    //                return BotterSettingsManager.language == .arabic && !(currentVC is b_ChatViewController)
    //                }
    //            }
    //         return false
    //        }
    
}
