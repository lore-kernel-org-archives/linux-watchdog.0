Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:35939 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752204AbaJMMF0 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 13 Oct 2014 08:05:26 -0400
From: Thierry Reding <thierry.reding@gmail.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wim Van Sebroeck <wim@iguana.be>
Cc: Stephen Warren <swarren@wwwdotorg.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-watchdog@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH 1/2] clocksource: tegra: Refactor and cleanup
Date: Mon, 13 Oct 2014 14:05:21 +0200
Message-Id: <1413201922-4210-1-git-send-email-thierry.reding@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Move all timer-related global variables into a single global structure
to make the code more driver-like. With that in place, register a proper
driver that will take over from the environment that was put in place at
early boot.

While at it, replace many of the magic values by their symbolic names.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/clocksource/tegra20_timer.c | 246 ++++++++++++++++++++++++------------
 1 file changed, 165 insertions(+), 81 deletions(-)

diff --git a/drivers/clocksource/tegra20_timer.c b/drivers/clocksource/tegra20_timer.c
index d2616ef16770..b576091ce37a 100644
--- a/drivers/clocksource/tegra20_timer.c
+++ b/drivers/clocksource/tegra20_timer.c
@@ -26,6 +26,7 @@
 #include <linux/io.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/platform_device.h>
 #include <linux/sched_clock.h>
 #include <linux/delay.h>
 
@@ -40,49 +41,73 @@
 #define TIMERUS_USEC_CFG 0x14
 #define TIMERUS_CNTR_FREEZE 0x4c
 
-#define TIMER1_BASE 0x0
-#define TIMER2_BASE 0x8
-#define TIMER3_BASE 0x50
-#define TIMER4_BASE 0x58
+#define TIMER1_BASE 0x000
+#define TIMER2_BASE 0x008
+#define TIMER3_BASE 0x050
+#define TIMER4_BASE 0x058
+#define TIMER5_BASE 0x060
 
 #define TIMER_PTV 0x0
+#define  TIMER_PTV_ENABLE   (1 << 31)
+#define  TIMER_PTV_PERIODIC (1 << 30)
+
 #define TIMER_PCR 0x4
+#define  TIMER_PCR_INTR_CLR (1 << 30)
+
+struct tegra_timer {
+	void __iomem *base;
+	struct clk *clk;
+	int irq;
+
+	struct clock_event_device clockevent;
+	struct delay_timer delay;
+
+	u32 usec_cfg;
+};
+
+static inline void timer_writel(struct tegra_timer *timer, u32 value,
+				unsigned long offset)
+{
+	writel(value, timer->base + offset);
+}
+
+static inline u32 timer_readl(struct tegra_timer *timer, unsigned long offset)
+{
+	return readl(timer->base + offset);
+}
+
+static struct tegra_timer *timer = &(struct tegra_timer) {
+	.base = NULL,
+};
 
-static void __iomem *timer_reg_base;
 static void __iomem *rtc_base;
 
 static struct timespec persistent_ts;
 static u64 persistent_ms, last_persistent_ms;
 
-static struct delay_timer tegra_delay_timer;
-
-#define timer_writel(value, reg) \
-	__raw_writel(value, timer_reg_base + (reg))
-#define timer_readl(reg) \
-	__raw_readl(timer_reg_base + (reg))
-
 static int tegra_timer_set_next_event(unsigned long cycles,
 					 struct clock_event_device *evt)
 {
-	u32 reg;
+	u32 value;
 
-	reg = 0x80000000 | ((cycles > 1) ? (cycles-1) : 0);
-	timer_writel(reg, TIMER3_BASE + TIMER_PTV);
+	value = TIMER_PTV_ENABLE | ((cycles > 1) ? (cycles - 1) : 0);
+	timer_writel(timer, value, TIMER3_BASE + TIMER_PTV);
 
 	return 0;
 }
 
 static void tegra_timer_set_mode(enum clock_event_mode mode,
-				    struct clock_event_device *evt)
+				 struct clock_event_device *evt)
 {
-	u32 reg;
+	u32 value;
 
-	timer_writel(0, TIMER3_BASE + TIMER_PTV);
+	timer_writel(timer, 0, TIMER3_BASE + TIMER_PTV);
 
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
-		reg = 0xC0000000 | ((1000000/HZ)-1);
-		timer_writel(reg, TIMER3_BASE + TIMER_PTV);
+		value = TIMER_PTV_ENABLE | TIMER_PTV_PERIODIC |
+			((USEC_PER_SEC / HZ) - 1);
+		timer_writel(timer, value, TIMER3_BASE + TIMER_PTV);
 		break;
 	case CLOCK_EVT_MODE_ONESHOT:
 		break;
@@ -93,17 +118,9 @@ static void tegra_timer_set_mode(enum clock_event_mode mode,
 	}
 }
 
-static struct clock_event_device tegra_clockevent = {
-	.name		= "timer0",
-	.rating		= 300,
-	.features	= CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC,
-	.set_next_event	= tegra_timer_set_next_event,
-	.set_mode	= tegra_timer_set_mode,
-};
-
 static u64 notrace tegra_read_sched_clock(void)
 {
-	return timer_readl(TIMERUS_CNTR_1US);
+	return timer_readl(timer, TIMERUS_CNTR_1US);
 }
 
 /*
@@ -144,90 +161,113 @@ static void tegra_read_persistent_clock(struct timespec *ts)
 
 static unsigned long tegra_delay_timer_read_counter_long(void)
 {
-	return readl(timer_reg_base + TIMERUS_CNTR_1US);
+	return timer_readl(timer, TIMERUS_CNTR_1US);
 }
 
 static irqreturn_t tegra_timer_interrupt(int irq, void *dev_id)
 {
-	struct clock_event_device *evt = (struct clock_event_device *)dev_id;
-	timer_writel(1<<30, TIMER3_BASE + TIMER_PCR);
-	evt->event_handler(evt);
+	struct tegra_timer *timer = dev_id;
+
+	timer_writel(timer, TIMER_PCR_INTR_CLR, TIMER3_BASE + TIMER_PCR);
+	timer->clockevent.event_handler(&timer->clockevent);
+
 	return IRQ_HANDLED;
 }
 
-static struct irqaction tegra_timer_irq = {
-	.name		= "timer0",
-	.flags		= IRQF_TIMER | IRQF_TRIGGER_HIGH,
-	.handler	= tegra_timer_interrupt,
-	.dev_id		= &tegra_clockevent,
+static const struct tegra_usec_config{
+	unsigned long input;
+	unsigned int mul;
+	unsigned int div;
+} tegra_usec_configs[] = {
+	{ 12000000, 1,  12 },
+	{ 13000000, 1,  13 },
+	{ 16800000, 5,  84 },
+	{ 19200000, 5,  96 },
+	{ 26000000, 1,  26 },
+	{ 38400000, 5, 192 },
+	{ 48000000, 1,  48 },
 };
 
+static const struct tegra_usec_config *
+tegra_timer_get_usec_config(unsigned long rate)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(tegra_usec_configs); i++)
+		if (tegra_usec_configs[i].input == rate)
+			return &tegra_usec_configs[i];
+
+	return NULL;
+}
+
 static void __init tegra20_init_timer(struct device_node *np)
 {
-	struct clk *clk;
+	const struct tegra_usec_config *cfg;
 	unsigned long rate;
 	int ret;
 
-	timer_reg_base = of_iomap(np, 0);
-	if (!timer_reg_base) {
+	timer->base = of_iomap(np, 0);
+	if (!timer->base) {
 		pr_err("Can't map timer registers\n");
 		BUG();
 	}
 
-	tegra_timer_irq.irq = irq_of_parse_and_map(np, 2);
-	if (tegra_timer_irq.irq <= 0) {
+	timer->irq = irq_of_parse_and_map(np, 2);
+	if (timer->irq == 0) {
 		pr_err("Failed to map timer IRQ\n");
 		BUG();
 	}
 
-	clk = of_clk_get(np, 0);
-	if (IS_ERR(clk)) {
-		pr_warn("Unable to get timer clock. Assuming 12Mhz input clock.\n");
+	timer->clk = of_clk_get(np, 0);
+	if (IS_ERR(timer->clk)) {
+		pr_warn("Unable to get timer clock. Assuming 12MHz input clock.\n");
 		rate = 12000000;
 	} else {
-		clk_prepare_enable(clk);
-		rate = clk_get_rate(clk);
+		ret = clk_prepare_enable(timer->clk);
+		if (ret < 0) {
+			pr_err("Failed to enable clock: %d\n", ret);
+			BUG();
+		}
+
+		rate = clk_get_rate(timer->clk);
 	}
 
-	switch (rate) {
-	case 12000000:
-		timer_writel(0x000b, TIMERUS_USEC_CFG);
-		break;
-	case 13000000:
-		timer_writel(0x000c, TIMERUS_USEC_CFG);
-		break;
-	case 19200000:
-		timer_writel(0x045f, TIMERUS_USEC_CFG);
-		break;
-	case 26000000:
-		timer_writel(0x0019, TIMERUS_USEC_CFG);
-		break;
-	default:
-		WARN(1, "Unknown clock rate");
+	cfg = tegra_timer_get_usec_config(rate);
+	if (!WARN(cfg == NULL, "Unknown clock rate: %lu Hz", rate)) {
+		u32 value = ((cfg->mul - 1) << 8) | (cfg->div - 1);
+		timer_writel(timer, value, TIMERUS_USEC_CFG);
 	}
 
-	sched_clock_register(tegra_read_sched_clock, 32, 1000000);
+	sched_clock_register(tegra_read_sched_clock, 32, USEC_PER_SEC);
 
-	if (clocksource_mmio_init(timer_reg_base + TIMERUS_CNTR_1US,
-		"timer_us", 1000000, 300, 32, clocksource_mmio_readl_up)) {
+	if (clocksource_mmio_init(timer->base + TIMERUS_CNTR_1US, "timer_us",
+				  USEC_PER_SEC, 300, 32,
+				  clocksource_mmio_readl_up)) {
 		pr_err("Failed to register clocksource\n");
 		BUG();
 	}
 
-	tegra_delay_timer.read_current_timer =
-			tegra_delay_timer_read_counter_long;
-	tegra_delay_timer.freq = 1000000;
-	register_current_timer_delay(&tegra_delay_timer);
+	timer->delay.read_current_timer = tegra_delay_timer_read_counter_long;
+	timer->delay.freq = USEC_PER_SEC;
+	register_current_timer_delay(&timer->delay);
 
-	ret = setup_irq(tegra_timer_irq.irq, &tegra_timer_irq);
-	if (ret) {
+	ret = request_irq(timer->irq, tegra_timer_interrupt,
+			  IRQF_TIMER | IRQF_TRIGGER_HIGH, "timer0", timer);
+	if (ret < 0) {
 		pr_err("Failed to register timer IRQ: %d\n", ret);
 		BUG();
 	}
 
-	tegra_clockevent.cpumask = cpu_all_mask;
-	tegra_clockevent.irq = tegra_timer_irq.irq;
-	clockevents_config_and_register(&tegra_clockevent, 1000000,
+	timer->clockevent.set_next_event = tegra_timer_set_next_event;
+	timer->clockevent.set_mode = tegra_timer_set_mode;
+	timer->clockevent.features = CLOCK_EVT_FEAT_ONESHOT |
+				     CLOCK_EVT_FEAT_PERIODIC;
+	timer->clockevent.name = "timer0";
+	timer->clockevent.rating = 300;
+	timer->clockevent.irq = timer->irq;
+	timer->clockevent.cpumask = cpu_all_mask;
+
+	clockevents_config_and_register(&timer->clockevent, USEC_PER_SEC,
 					0x1, 0x1fffffff);
 }
 CLOCKSOURCE_OF_DECLARE(tegra20_timer, "nvidia,tegra20-timer", tegra20_init_timer);
@@ -256,16 +296,60 @@ static void __init tegra20_init_rtc(struct device_node *np)
 }
 CLOCKSOURCE_OF_DECLARE(tegra20_rtc, "nvidia,tegra20-rtc", tegra20_init_rtc);
 
-#ifdef CONFIG_PM
-static u32 usec_config;
+static int tegra_timer_probe(struct platform_device *pdev)
+{
+	struct resource *regs;
+	void __iomem *base;
+
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(&pdev->dev, regs);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
 
-void tegra_timer_suspend(void)
+	platform_set_drvdata(pdev, timer);
+	timer->base = base;
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int tegra_timer_suspend(struct device *dev)
 {
-	usec_config = timer_readl(TIMERUS_USEC_CFG);
+	struct tegra_timer *timer = dev_get_drvdata(dev);
+
+	timer->usec_cfg = timer_readl(timer, TIMERUS_USEC_CFG);
+
+	return 0;
 }
 
-void tegra_timer_resume(void)
+static int tegra_timer_resume(struct device *dev)
 {
-	timer_writel(usec_config, TIMERUS_USEC_CFG);
+	struct tegra_timer *timer = dev_get_drvdata(dev);
+
+	timer_writel(timer, timer->usec_cfg, TIMERUS_USEC_CFG);
+
+	return 0;
 }
 #endif
+
+static SIMPLE_DEV_PM_OPS(tegra_timer_pm_ops, tegra_timer_suspend,
+			 tegra_timer_resume);
+
+static const struct of_device_id tegra_timer_of_match[] = {
+	{ .compatible = "nvidia,tegra124-timer", },
+	{ .compatible = "nvidia,tegra114-timer", },
+	{ .compatible = "nvidia,tegra30-timer", },
+	{ .compatible = "nvidia,tegra20-timer", },
+	{ }
+};
+
+static struct platform_driver tegra_timer_driver = {
+	.driver = {
+		.name = "tegra-timer",
+		.pm = &tegra_timer_pm_ops,
+		.of_match_table = tegra_timer_of_match,
+		.suppress_bind_attrs = true,
+	},
+	.probe = tegra_timer_probe,
+};
+module_platform_driver(tegra_timer_driver);
-- 
2.1.2

