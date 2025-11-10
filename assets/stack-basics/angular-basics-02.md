# Chapter 2: TypeScript 기초

안녕하세요! 바데부입니다! Angular를 사용하려면 TypeScript를 알아야 해요. 걱정 마세요, 재미있게 배워봅시다! 📘

## 2.1 TypeScript란?

TypeScript는 JavaScript에 타입 시스템을 추가한 프로그래밍 언어예요. Microsoft가 개발했고, JavaScript의 슈퍼셋이에요!

**TypeScript의 장점:**
- 컴파일 타임에 오류 발견
- 강력한 IDE 지원 (자동완성, 리팩토링)
- 코드 가독성 향상
- 대규모 프로젝트에 적합

```typescript
// JavaScript
function greet(name) {
  return "안녕하세요, " + name;
}

// TypeScript
function greet(name: string): string {
  return "안녕하세요, " + name;
}

greet("바데부");    // ✅ 정상
greet(123);        // ❌ 오류: number는 string이 아님
```

## 2.2 기본 타입 (Primitive Types)

### String (문자열)
```typescript
let userName: string = "바데부";
let message: string = 'Angular는 재미있어요!';
let template: string = `안녕하세요, ${userName}!`;

console.log(template);  // 안녕하세요, 바데부!
```

### Number (숫자)
```typescript
let age: number = 3;
let score: number = 95.5;
let hex: number = 0xf00d;
let binary: number = 0b1010;
```

### Boolean (불린)
```typescript
let isActive: boolean = true;
let isCompleted: boolean = false;

if (isActive) {
  console.log("활성 상태입니다!");
}
```

### Array (배열)
```typescript
// 방법 1: 타입[]
let numbers: number[] = [1, 2, 3, 4, 5];
let names: string[] = ["바데부", "철수", "영희"];

// 방법 2: Array<타입>
let scores: Array<number> = [90, 85, 95];
let users: Array<string> = ["user1", "user2"];

// 배열 사용
numbers.push(6);
names.forEach(name => console.log(name));
```

### Tuple (튜플)
```typescript
// 고정된 길이와 타입의 배열
let user: [string, number] = ["바데부", 3];

console.log(user[0]);  // 바데부
console.log(user[1]);  // 3

// ❌ 잘못된 타입
user = [3, "바데부"];  // 오류!
```

### Enum (열거형)
```typescript
enum Color {
  Red,
  Green,
  Blue
}

let myColor: Color = Color.Red;
console.log(myColor);  // 0

// 값 지정
enum Status {
  Active = "ACTIVE",
  Inactive = "INACTIVE",
  Pending = "PENDING"
}

let userStatus: Status = Status.Active;
console.log(userStatus);  // ACTIVE
```

### Any (모든 타입)
```typescript
// any는 모든 타입을 허용 (가급적 사용 지양)
let value: any = "바데부";
value = 123;       // ✅ 가능
value = true;      // ✅ 가능
value = [];        // ✅ 가능
```

### Unknown (알 수 없는 타입)
```typescript
// unknown은 any보다 안전
let value: unknown = "바데부";

// ❌ 타입 확인 없이 사용 불가
let name: string = value;  // 오류!

// ✅ 타입 확인 후 사용
if (typeof value === "string") {
  let name: string = value;  // 정상
}
```

## 2.3 인터페이스 (Interface)

인터페이스는 객체의 구조를 정의해요!

### 기본 인터페이스
```typescript
interface User {
  name: string;
  age: number;
  email: string;
}

const badb: User = {
  name: "바데부",
  age: 3,
  email: "badb@vibedev.com"
};

// ❌ 프로퍼티 누락
const user2: User = {
  name: "철수"
  // age와 email이 없음 - 오류!
};
```

### 선택적 프로퍼티
```typescript
interface User {
  name: string;
  age: number;
  email?: string;  // ? = 선택적
  phone?: string;
}

const user: User = {
  name: "바데부",
  age: 3
  // email과 phone은 생략 가능
};
```

### 읽기 전용 프로퍼티
```typescript
interface User {
  readonly id: number;
  name: string;
}

const user: User = {
  id: 1,
  name: "바데부"
};

user.name = "새 이름";  // ✅ 가능
user.id = 2;          // ❌ 오류: 읽기 전용
```

### 메서드가 있는 인터페이스
```typescript
interface User {
  name: string;
  age: number;
  greet(): string;
  getAge(): number;
}

const badb: User = {
  name: "바데부",
  age: 3,
  greet() {
    return `안녕하세요, ${this.name}입니다!`;
  },
  getAge() {
    return this.age;
  }
};

console.log(badb.greet());  // 안녕하세요, 바데부입니다!
```

## 2.4 클래스 (Class)

### 기본 클래스
```typescript
class User {
  name: string;
  age: number;

  constructor(name: string, age: number) {
    this.name = name;
    this.age = age;
  }

  greet(): string {
    return `안녕하세요, ${this.name}입니다!`;
  }
}

const badb = new User("바데부", 3);
console.log(badb.greet());  // 안녕하세요, 바데부입니다!
```

### 접근 제어자
```typescript
class User {
  public name: string;      // 어디서나 접근 가능 (기본값)
  private age: number;      // 클래스 내부에서만 접근
  protected email: string;  // 클래스와 서브클래스에서 접근

  constructor(name: string, age: number, email: string) {
    this.name = name;
    this.age = age;
    this.email = email;
  }

  getAge(): number {
    return this.age;  // ✅ 클래스 내부에서는 접근 가능
  }
}

const user = new User("바데부", 3, "badb@vibedev.com");
console.log(user.name);   // ✅ public
console.log(user.age);    // ❌ 오류: private
console.log(user.getAge()); // ✅ 메서드를 통해 접근
```

### 짧은 문법
```typescript
// 생성자에서 프로퍼티 선언
class User {
  constructor(
    public name: string,
    private age: number,
    protected email: string
  ) {}

  greet(): string {
    return `안녕하세요, ${this.name}입니다!`;
  }
}

const badb = new User("바데부", 3, "badb@vibedev.com");
```

### 상속
```typescript
class Animal {
  constructor(public name: string) {}

  move(distance: number): void {
    console.log(`${this.name}이(가) ${distance}m 이동했습니다.`);
  }
}

class Dog extends Animal {
  bark(): void {
    console.log("멍멍!");
  }
}

const dog = new Dog("바둑이");
dog.move(10);  // 바둑이이(가) 10m 이동했습니다.
dog.bark();    // 멍멍!
```

## 2.5 함수 (Functions)

### 함수 타입 지정
```typescript
// 매개변수와 반환 타입 지정
function add(a: number, b: number): number {
  return a + b;
}

// 화살표 함수
const multiply = (a: number, b: number): number => {
  return a * b;
};

// 짧은 화살표 함수
const divide = (a: number, b: number): number => a / b;
```

### 선택적 매개변수
```typescript
function greet(name: string, greeting?: string): string {
  if (greeting) {
    return `${greeting}, ${name}!`;
  }
  return `안녕하세요, ${name}!`;
}

console.log(greet("바데부"));              // 안녕하세요, 바데부!
console.log(greet("바데부", "환영합니다")); // 환영합니다, 바데부!
```

### 기본 매개변수
```typescript
function greet(name: string, greeting: string = "안녕하세요"): string {
  return `${greeting}, ${name}!`;
}

console.log(greet("바데부"));  // 안녕하세요, 바데부!
```

### Rest 매개변수
```typescript
function sum(...numbers: number[]): number {
  return numbers.reduce((total, num) => total + num, 0);
}

console.log(sum(1, 2, 3));        // 6
console.log(sum(1, 2, 3, 4, 5));  // 15
```

## 2.6 제네릭 (Generics)

제네릭은 재사용 가능한 컴포넌트를 만들 때 사용해요!

### 기본 제네릭
```typescript
function identity<T>(arg: T): T {
  return arg;
}

let output1 = identity<string>("바데부");
let output2 = identity<number>(123);
let output3 = identity(true);  // 타입 추론
```

### 제네릭 인터페이스
```typescript
interface Response<T> {
  data: T;
  status: number;
  message: string;
}

const userResponse: Response<User> = {
  data: { name: "바데부", age: 3, email: "badb@vibedev.com" },
  status: 200,
  message: "성공"
};

const numberResponse: Response<number> = {
  data: 123,
  status: 200,
  message: "성공"
};
```

### 제네릭 클래스
```typescript
class DataStorage<T> {
  private data: T[] = [];

  addItem(item: T): void {
    this.data.push(item);
  }

  removeItem(item: T): void {
    this.data = this.data.filter(i => i !== item);
  }

  getItems(): T[] {
    return [...this.data];
  }
}

const textStorage = new DataStorage<string>();
textStorage.addItem("바데부");
textStorage.addItem("Angular");

const numberStorage = new DataStorage<number>();
numberStorage.addItem(1);
numberStorage.addItem(2);
```

## 2.7 타입 별칭 (Type Alias)

```typescript
// 타입 별칭
type UserID = string | number;
type Status = "active" | "inactive" | "pending";

let userId: UserID = "user123";
userId = 123;  // ✅ 가능

let status: Status = "active";
status = "deleted";  // ❌ 오류!

// 객체 타입 별칭
type User = {
  id: UserID;
  name: string;
  status: Status;
};

const user: User = {
  id: "user123",
  name: "바데부",
  status: "active"
};
```

## 2.8 유니온과 인터섹션 타입

### 유니온 타입 (Union)
```typescript
// | = 또는
type StringOrNumber = string | number;

let value: StringOrNumber = "바데부";
value = 123;  // ✅ 둘 다 가능

function printId(id: string | number): void {
  if (typeof id === "string") {
    console.log(id.toUpperCase());
  } else {
    console.log(id.toFixed(2));
  }
}
```

### 인터섹션 타입 (Intersection)
```typescript
// & = 그리고
interface Person {
  name: string;
  age: number;
}

interface Developer {
  skills: string[];
}

type DevPerson = Person & Developer;

const badb: DevPerson = {
  name: "바데부",
  age: 3,
  skills: ["Angular", "TypeScript", "RxJS"]
};
```

## 2.9 타입 단언 (Type Assertion)

```typescript
// 방법 1: as 키워드
let value: any = "바데부";
let length: number = (value as string).length;

// 방법 2: <타입> 문법 (JSX에서는 사용 불가)
let length2: number = (<string>value).length;

// DOM 요소
const input = document.getElementById("username") as HTMLInputElement;
input.value = "바데부";
```

## 2.10 유틸리티 타입

### Partial - 모든 프로퍼티를 선택적으로
```typescript
interface User {
  name: string;
  age: number;
  email: string;
}

function updateUser(user: User, updates: Partial<User>): User {
  return { ...user, ...updates };
}

const user: User = { name: "바데부", age: 3, email: "badb@vibedev.com" };
const updated = updateUser(user, { age: 4 });
```

### Readonly - 모든 프로퍼티를 읽기 전용으로
```typescript
interface User {
  name: string;
  age: number;
}

const user: Readonly<User> = { name: "바데부", age: 3 };
user.age = 4;  // ❌ 오류: 읽기 전용
```

### Pick - 특정 프로퍼티만 선택
```typescript
interface User {
  id: number;
  name: string;
  age: number;
  email: string;
}

type UserPreview = Pick<User, "id" | "name">;

const preview: UserPreview = {
  id: 1,
  name: "바데부"
};
```

### Omit - 특정 프로퍼티 제외
```typescript
type UserWithoutEmail = Omit<User, "email">;

const user: UserWithoutEmail = {
  id: 1,
  name: "바데부",
  age: 3
};
```

## 연습 문제

1. User 인터페이스를 만들고, name, age, email 프로퍼티를 추가하세요
2. 제네릭 함수를 만들어 배열의 첫 번째 요소를 반환하세요
3. Status 타입을 만들고 "active", "inactive", "pending"만 허용하세요
4. Animal 클래스를 만들고 Dog 클래스로 상속하세요

## 다음 단계

다음 챕터에서는 **컴포넌트와 템플릿**을 배워봅시다! TypeScript로 Angular 컴포넌트를 만들 거예요!

## 핵심 요약

- TypeScript는 JavaScript에 타입을 추가한 언어
- 기본 타입: string, number, boolean, array, tuple, enum
- 인터페이스로 객체 구조를 정의
- 클래스로 객체 지향 프로그래밍
- 제네릭으로 재사용 가능한 컴포넌트 작성
- 유니온(|)과 인터섹션(&)으로 타입 조합
- 유틸리티 타입으로 타입 변환 (Partial, Readonly, Pick, Omit)

바데부와 함께 TypeScript를 마스터해봅시다! 💪
