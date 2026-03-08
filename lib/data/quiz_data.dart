import '../models/question_model.dart';

/// بيانات الاختبار السياسي - 10 أسئلة حول الوعي السياسي في الأردن
/// كل سؤال له 4 خيارات، كل خيار يحمل نقاطاً من 0 إلى 3
/// الحد الأقصى للنقاط: 30 نقطة
const List<QuestionModel> quizQuestions = [
  // السؤال 1
  QuestionModel(
    questionText: 'ما هو النظام السياسي المعمول به في المملكة الأردنية الهاشمية؟',
    options: [
      AnswerOption(text: 'جمهورية رئاسية', points: 0),
      AnswerOption(text: 'ملكية دستورية', points: 3),
      AnswerOption(text: 'نظام فيدرالي', points: 0),
      AnswerOption(text: 'ديمقراطية برلمانية كاملة', points: 1),
    ],
  ),

  // السؤال 2
  QuestionModel(
    questionText: 'كم عدد مجلسي البرلمان الأردني (مجلس الأمة)؟',
    options: [
      AnswerOption(text: 'مجلس واحد فقط', points: 0),
      AnswerOption(text: 'ثلاثة مجالس', points: 0),
      AnswerOption(text: 'مجلسان: النواب والأعيان', points: 3),
      AnswerOption(text: 'أربعة مجالس', points: 0),
    ],
  ),

  // السؤال 3
  QuestionModel(
    questionText: 'ما الجهة المنوط بها تعيين رئيس الوزراء في الأردن؟',
    options: [
      AnswerOption(text: 'مجلس النواب بالتصويت', points: 1),
      AnswerOption(text: 'الملك بموجب الدستور', points: 3),
      AnswerOption(text: 'مجلس الأعيان', points: 0),
      AnswerOption(text: 'الشعب مباشرةً عبر انتخابات', points: 0),
    ],
  ),

  // السؤال 4
  QuestionModel(
    questionText: 'ما هي الكوتا المخصصة للمرأة في مجلس النواب الأردني؟',
    options: [
      AnswerOption(text: 'لا توجد كوتا للمرأة', points: 0),
      AnswerOption(text: '10 مقاعد', points: 0),
      AnswerOption(text: '15 مقعداً على الأقل', points: 3),
      AnswerOption(text: '30 مقعداً', points: 1),
    ],
  ),

  // السؤال 5
  QuestionModel(
    questionText: 'ما السن القانونية للتصويت في الانتخابات الأردنية؟',
    options: [
      AnswerOption(text: '16 سنة', points: 0),
      AnswerOption(text: '18 سنة', points: 3),
      AnswerOption(text: '21 سنة', points: 0),
      AnswerOption(text: '25 سنة', points: 0),
    ],
  ),

  // السؤال 6
  QuestionModel(
    questionText: 'ما دور الهيئة المستقلة للانتخاب في الأردن؟',
    options: [
      AnswerOption(text: 'إقرار القوانين الانتخابية فقط', points: 1),
      AnswerOption(text: 'الإشراف على الانتخابات وضمان نزاهتها', points: 3),
      AnswerOption(text: 'تعيين أعضاء مجلس الأعيان', points: 0),
      AnswerOption(text: 'ليس لها صلاحيات قانونية', points: 0),
    ],
  ),

  // السؤال 7
  QuestionModel(
    questionText: 'ما المقصود بـ"فصل السلطات" في النظام الديمقراطي؟',
    options: [
      AnswerOption(text: 'تقسيم الدولة إلى مناطق إدارية', points: 0),
      AnswerOption(text: 'توزيع الصلاحيات بين الحكومة المركزية والمحلية', points: 1),
      AnswerOption(text: 'توزيع السلطة بين التشريعية والتنفيذية والقضائية', points: 3),
      AnswerOption(text: 'تقسيم الميزانية بين الوزارات', points: 0),
    ],
  ),

  // السؤال 8
  QuestionModel(
    questionText: 'ما الذي تعنيه "الشفافية" في السياق السياسي؟',
    options: [
      AnswerOption(text: 'إخفاء المعلومات الحساسة عن الجمهور', points: 0),
      AnswerOption(text: 'انفتاح الحكومة وإتاحة المعلومات للمواطنين', points: 3),
      AnswerOption(text: 'سرعة اتخاذ القرارات الحكومية', points: 1),
      AnswerOption(text: 'تطبيق القوانين بصرامة', points: 1),
    ],
  ),

  // السؤال 9
  QuestionModel(
    questionText: 'ما حق "المواطنة الفاعلة" الأهم للمشاركة السياسية؟',
    options: [
      AnswerOption(text: 'دفع الضرائب فقط', points: 0),
      AnswerOption(text: 'الاطلاع على الأخبار يومياً', points: 1),
      AnswerOption(text: 'التصويت والمشاركة في الحياة السياسية والمجتمعية', points: 3),
      AnswerOption(text: 'الانضمام إلى الجيش', points: 0),
    ],
  ),

  // السؤال 10
  QuestionModel(
    questionText: 'ما وظيفة المعارضة السياسية في النظام الديمقراطي؟',
    options: [
      AnswerOption(text: 'إسقاط الحكومة بأي وسيلة', points: 0),
      AnswerOption(text: 'الرقابة على أداء الحكومة وتقديم بدائل سياسية', points: 3),
      AnswerOption(text: 'ليس لها دور فعلي', points: 0),
      AnswerOption(text: 'تمثيل مصالح الدول الأخرى', points: 0),
    ],
  ),
];
