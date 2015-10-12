Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:5731 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752674AbbJLXmA (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 12 Oct 2015 19:42:00 -0400
Date: Tue, 13 Oct 2015 07:41:10 +0800
From: kbuild test robot <lkp@intel.com>
To: Luis de Bethencourt <luisbg@osg.samsung.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org, wim@iguana.be,
	javier@osg.samsung.com,
	Luis de Bethencourt <luisbg@osg.samsung.com>
Subject: Re: [PATCH] watchdog: Compile possible drivers with COMPILE_TEST
Message-ID: <201510130736.z4s9t9Xt%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1444682761-25900-1-git-send-email-luisbg@osg.samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Luis,

[auto build test WARNING on v4.3-rc5 -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Luis-de-Bethencourt/watchdog-Compile-possible-drivers-with-COMPILE_TEST/20151013-044814
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/watchdog/sirfsoc_wdt.c:48:18: sparse: incorrect type in assignment (different address spaces)
   drivers/watchdog/sirfsoc_wdt.c:48:18:    expected void [noderef] <asn:2>*wdt_base
   drivers/watchdog/sirfsoc_wdt.c:48:18:    got void *
   drivers/watchdog/sirfsoc_wdt.c:64:18: sparse: incorrect type in assignment (different address spaces)
   drivers/watchdog/sirfsoc_wdt.c:64:18:    expected void [noderef] <asn:2>*wdt_base
   drivers/watchdog/sirfsoc_wdt.c:64:18:    got void *
>> drivers/watchdog/sirfsoc_wdt.c:82:54: sparse: incorrect type in initializer (different address spaces)
   drivers/watchdog/sirfsoc_wdt.c:82:54:    expected void [noderef] <asn:2>*wdt_base
   drivers/watchdog/sirfsoc_wdt.c:82:54:    got void *
   drivers/watchdog/sirfsoc_wdt.c:99:54: sparse: incorrect type in initializer (different address spaces)
   drivers/watchdog/sirfsoc_wdt.c:99:54:    expected void [noderef] <asn:2>*wdt_base
   drivers/watchdog/sirfsoc_wdt.c:99:54:    got void *
>> drivers/watchdog/sirfsoc_wdt.c:153:44: sparse: incorrect type in argument 2 (different address spaces)
   drivers/watchdog/sirfsoc_wdt.c:153:44:    expected void *data
   drivers/watchdog/sirfsoc_wdt.c:153:44:    got void [noderef] <asn:2>*[assigned] base

vim +48 drivers/watchdog/sirfsoc_wdt.c

f0fcbdbf Xianglong Du     2013-10-02   42  static unsigned int sirfsoc_wdt_gettimeleft(struct watchdog_device *wdd)
f0fcbdbf Xianglong Du     2013-10-02   43  {
f0fcbdbf Xianglong Du     2013-10-02   44  	u32 counter, match;
f0fcbdbf Xianglong Du     2013-10-02   45  	void __iomem *wdt_base;
f0fcbdbf Xianglong Du     2013-10-02   46  	int time_left;
f0fcbdbf Xianglong Du     2013-10-02   47  
f0fcbdbf Xianglong Du     2013-10-02  @48  	wdt_base = watchdog_get_drvdata(wdd);
f0fcbdbf Xianglong Du     2013-10-02   49  	counter = readl(wdt_base + SIRFSOC_TIMER_COUNTER_LO);
f0fcbdbf Xianglong Du     2013-10-02   50  	match = readl(wdt_base +
f0fcbdbf Xianglong Du     2013-10-02   51  		SIRFSOC_TIMER_MATCH_0 + (SIRFSOC_TIMER_WDT_INDEX << 2));
f0fcbdbf Xianglong Du     2013-10-02   52  
f0fcbdbf Xianglong Du     2013-10-02   53  	time_left = match - counter;
f0fcbdbf Xianglong Du     2013-10-02   54  
b0df38dd Uwe Kleine-König 2013-11-11   55  	return time_left / CLOCK_FREQ;
f0fcbdbf Xianglong Du     2013-10-02   56  }
f0fcbdbf Xianglong Du     2013-10-02   57  
f0fcbdbf Xianglong Du     2013-10-02   58  static int sirfsoc_wdt_updatetimeout(struct watchdog_device *wdd)
f0fcbdbf Xianglong Du     2013-10-02   59  {
f0fcbdbf Xianglong Du     2013-10-02   60  	u32 counter, timeout_ticks;
f0fcbdbf Xianglong Du     2013-10-02   61  	void __iomem *wdt_base;
f0fcbdbf Xianglong Du     2013-10-02   62  
b0df38dd Uwe Kleine-König 2013-11-11   63  	timeout_ticks = wdd->timeout * CLOCK_FREQ;
f0fcbdbf Xianglong Du     2013-10-02  @64  	wdt_base = watchdog_get_drvdata(wdd);
f0fcbdbf Xianglong Du     2013-10-02   65  
f0fcbdbf Xianglong Du     2013-10-02   66  	/* Enable the latch before reading the LATCH_LO register */
f0fcbdbf Xianglong Du     2013-10-02   67  	writel(1, wdt_base + SIRFSOC_TIMER_LATCH);
f0fcbdbf Xianglong Du     2013-10-02   68  
f0fcbdbf Xianglong Du     2013-10-02   69  	/* Set the TO value */
f0fcbdbf Xianglong Du     2013-10-02   70  	counter = readl(wdt_base + SIRFSOC_TIMER_LATCHED_LO);
f0fcbdbf Xianglong Du     2013-10-02   71  
f0fcbdbf Xianglong Du     2013-10-02   72  	counter += timeout_ticks;
f0fcbdbf Xianglong Du     2013-10-02   73  
f0fcbdbf Xianglong Du     2013-10-02   74  	writel(counter, wdt_base +
f0fcbdbf Xianglong Du     2013-10-02   75  		SIRFSOC_TIMER_MATCH_0 + (SIRFSOC_TIMER_WDT_INDEX << 2));
f0fcbdbf Xianglong Du     2013-10-02   76  
f0fcbdbf Xianglong Du     2013-10-02   77  	return 0;
f0fcbdbf Xianglong Du     2013-10-02   78  }
f0fcbdbf Xianglong Du     2013-10-02   79  
f0fcbdbf Xianglong Du     2013-10-02   80  static int sirfsoc_wdt_enable(struct watchdog_device *wdd)
f0fcbdbf Xianglong Du     2013-10-02   81  {
f0fcbdbf Xianglong Du     2013-10-02  @82  	void __iomem *wdt_base = watchdog_get_drvdata(wdd);
f0fcbdbf Xianglong Du     2013-10-02   83  	sirfsoc_wdt_updatetimeout(wdd);
f0fcbdbf Xianglong Du     2013-10-02   84  
f0fcbdbf Xianglong Du     2013-10-02   85  	/*
f0fcbdbf Xianglong Du     2013-10-02   86  	 * NOTE: If interrupt is not enabled
f0fcbdbf Xianglong Du     2013-10-02   87  	 * then WD-Reset doesn't get generated at all.
f0fcbdbf Xianglong Du     2013-10-02   88  	 */
f0fcbdbf Xianglong Du     2013-10-02   89  	writel(readl(wdt_base + SIRFSOC_TIMER_INT_EN)
f0fcbdbf Xianglong Du     2013-10-02   90  		| (1 << SIRFSOC_TIMER_WDT_INDEX),
f0fcbdbf Xianglong Du     2013-10-02   91  		wdt_base + SIRFSOC_TIMER_INT_EN);
f0fcbdbf Xianglong Du     2013-10-02   92  	writel(1, wdt_base + SIRFSOC_TIMER_WATCHDOG_EN);
f0fcbdbf Xianglong Du     2013-10-02   93  
f0fcbdbf Xianglong Du     2013-10-02   94  	return 0;
f0fcbdbf Xianglong Du     2013-10-02   95  }
f0fcbdbf Xianglong Du     2013-10-02   96  
f0fcbdbf Xianglong Du     2013-10-02   97  static int sirfsoc_wdt_disable(struct watchdog_device *wdd)
f0fcbdbf Xianglong Du     2013-10-02   98  {
f0fcbdbf Xianglong Du     2013-10-02   99  	void __iomem *wdt_base = watchdog_get_drvdata(wdd);
f0fcbdbf Xianglong Du     2013-10-02  100  
f0fcbdbf Xianglong Du     2013-10-02  101  	writel(0, wdt_base + SIRFSOC_TIMER_WATCHDOG_EN);
f0fcbdbf Xianglong Du     2013-10-02  102  	writel(readl(wdt_base + SIRFSOC_TIMER_INT_EN)
f0fcbdbf Xianglong Du     2013-10-02  103  		& (~(1 << SIRFSOC_TIMER_WDT_INDEX)),
f0fcbdbf Xianglong Du     2013-10-02  104  		wdt_base + SIRFSOC_TIMER_INT_EN);
f0fcbdbf Xianglong Du     2013-10-02  105  
f0fcbdbf Xianglong Du     2013-10-02  106  	return 0;
f0fcbdbf Xianglong Du     2013-10-02  107  }
f0fcbdbf Xianglong Du     2013-10-02  108  
f0fcbdbf Xianglong Du     2013-10-02  109  static int sirfsoc_wdt_settimeout(struct watchdog_device *wdd, unsigned int to)
f0fcbdbf Xianglong Du     2013-10-02  110  {
f0fcbdbf Xianglong Du     2013-10-02  111  	wdd->timeout = to;
f0fcbdbf Xianglong Du     2013-10-02  112  	sirfsoc_wdt_updatetimeout(wdd);
f0fcbdbf Xianglong Du     2013-10-02  113  
f0fcbdbf Xianglong Du     2013-10-02  114  	return 0;
f0fcbdbf Xianglong Du     2013-10-02  115  }
f0fcbdbf Xianglong Du     2013-10-02  116  
f0fcbdbf Xianglong Du     2013-10-02  117  #define OPTIONS (WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE)
f0fcbdbf Xianglong Du     2013-10-02  118  
f0fcbdbf Xianglong Du     2013-10-02  119  static const struct watchdog_info sirfsoc_wdt_ident = {
f0fcbdbf Xianglong Du     2013-10-02  120  	.options          =     OPTIONS,
f0fcbdbf Xianglong Du     2013-10-02  121  	.firmware_version =	0,
f0fcbdbf Xianglong Du     2013-10-02  122  	.identity         =	"SiRFSOC Watchdog",
f0fcbdbf Xianglong Du     2013-10-02  123  };
f0fcbdbf Xianglong Du     2013-10-02  124  
f0fcbdbf Xianglong Du     2013-10-02  125  static struct watchdog_ops sirfsoc_wdt_ops = {
f0fcbdbf Xianglong Du     2013-10-02  126  	.owner = THIS_MODULE,
f0fcbdbf Xianglong Du     2013-10-02  127  	.start = sirfsoc_wdt_enable,
f0fcbdbf Xianglong Du     2013-10-02  128  	.stop = sirfsoc_wdt_disable,
f0fcbdbf Xianglong Du     2013-10-02  129  	.get_timeleft = sirfsoc_wdt_gettimeleft,
f0fcbdbf Xianglong Du     2013-10-02  130  	.ping = sirfsoc_wdt_updatetimeout,
f0fcbdbf Xianglong Du     2013-10-02  131  	.set_timeout = sirfsoc_wdt_settimeout,
f0fcbdbf Xianglong Du     2013-10-02  132  };
f0fcbdbf Xianglong Du     2013-10-02  133  
f0fcbdbf Xianglong Du     2013-10-02  134  static struct watchdog_device sirfsoc_wdd = {
f0fcbdbf Xianglong Du     2013-10-02  135  	.info = &sirfsoc_wdt_ident,
f0fcbdbf Xianglong Du     2013-10-02  136  	.ops = &sirfsoc_wdt_ops,
f0fcbdbf Xianglong Du     2013-10-02  137  	.timeout = SIRFSOC_WDT_DEFAULT_TIMEOUT,
f0fcbdbf Xianglong Du     2013-10-02  138  	.min_timeout = SIRFSOC_WDT_MIN_TIMEOUT,
f0fcbdbf Xianglong Du     2013-10-02  139  	.max_timeout = SIRFSOC_WDT_MAX_TIMEOUT,
f0fcbdbf Xianglong Du     2013-10-02  140  };
f0fcbdbf Xianglong Du     2013-10-02  141  
f0fcbdbf Xianglong Du     2013-10-02  142  static int sirfsoc_wdt_probe(struct platform_device *pdev)
f0fcbdbf Xianglong Du     2013-10-02  143  {
f0fcbdbf Xianglong Du     2013-10-02  144  	struct resource *res;
f0fcbdbf Xianglong Du     2013-10-02  145  	int ret;
f0fcbdbf Xianglong Du     2013-10-02  146  	void __iomem *base;
f0fcbdbf Xianglong Du     2013-10-02  147  
f0fcbdbf Xianglong Du     2013-10-02  148  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
f0fcbdbf Xianglong Du     2013-10-02  149  	base = devm_ioremap_resource(&pdev->dev, res);
f0fcbdbf Xianglong Du     2013-10-02  150  	if (IS_ERR(base))
f0fcbdbf Xianglong Du     2013-10-02  151  		return PTR_ERR(base);
f0fcbdbf Xianglong Du     2013-10-02  152  
f0fcbdbf Xianglong Du     2013-10-02 @153  	watchdog_set_drvdata(&sirfsoc_wdd, base);
f0fcbdbf Xianglong Du     2013-10-02  154  
f0fcbdbf Xianglong Du     2013-10-02  155  	watchdog_init_timeout(&sirfsoc_wdd, timeout, &pdev->dev);
f0fcbdbf Xianglong Du     2013-10-02  156  	watchdog_set_nowayout(&sirfsoc_wdd, nowayout);

:::::: The code at line 48 was first introduced by commit
:::::: f0fcbdbf202e2be36c8eb6d1f5c01f95805777de watchdog: sirf: add watchdog driver of CSR SiRFprimaII and SiRFatlasVI

:::::: TO: Xianglong Du <Xianglong.Du@csr.com>
:::::: CC: Wim Van Sebroeck <wim@iguana.be>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
