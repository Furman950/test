using NUnit.Framework;

namespace NUnitTestProject1
{
    public class Tests
    {
        [SetUp]
        public void Setup()
        {
        }

        [Test]
        public void Test1()
        {
            bool validTest = true;
            Assert.IsTrue(validTest);
        }

        [Test]
        public void Test2()
        {
            bool validTest = true;
            Assert.IsTrue(validTest);
        }
    }
}