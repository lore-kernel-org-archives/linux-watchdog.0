Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: rt@linuxtronix.de, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org
Subject: [PATCH 11/20] watchdog/octeon: Convert to hotplug state machine
Date: Thu, 17 Nov 2016 19:35:32 +0100
Message-Id: <20161117183541.8588-12-bigeasy@linutronix.de>
In-Reply-To: <20161117183541.8588-1-bigeasy@linutronix.de>
References: <20161117183541.8588-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

Install the callbacks via the state machine and let the core invoke
the callbacks on the already online CPUs.

Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/watchdog/octeon-wdt-main.c | 62 +++++++++-------------------------=
----
 1 file changed, 15 insertions(+), 47 deletions(-)

diff --git a/drivers/watchdog/octeon-wdt-main.c b/drivers/watchdog/octeon-w=
dt-main.c
index b55981f88a08..529182d7d8a7 100644
--- a/drivers/watchdog/octeon-wdt-main.c
+++ b/drivers/watchdog/octeon-wdt-main.c
@@ -374,7 +374,7 @@ void octeon_wdt_nmi_stage3(u64 reg[32])
 	octeon_wdt_write_string("*** Chip soft reset soon ***\r\n");
 }
=20
-static void octeon_wdt_disable_interrupt(int cpu)
+static int octeon_wdt_cpu_pre_down(unsigned int cpu)
 {
 	unsigned int core;
 	unsigned int irq;
@@ -392,9 +392,10 @@ static void octeon_wdt_disable_interrupt(int cpu)
 	cvmx_write_csr(CVMX_CIU_WDOGX(core), ciu_wdog.u64);
=20
 	free_irq(irq, octeon_wdt_poke_irq);
+	return 0;
 }
=20
-static void octeon_wdt_setup_interrupt(int cpu)
+static int octeon_wdt_cpu_online(unsigned int cpu)
 {
 	unsigned int core;
 	unsigned int irq;
@@ -424,25 +425,8 @@ static void octeon_wdt_setup_interrupt(int cpu)
 	ciu_wdog.s.len =3D timeout_cnt;
 	ciu_wdog.s.mode =3D 3;	/* 3 =3D Interrupt + NMI + Soft-Reset */
 	cvmx_write_csr(CVMX_CIU_WDOGX(core), ciu_wdog.u64);
-}
=20
-static int octeon_wdt_cpu_callback(struct notifier_block *nfb,
-					   unsigned long action, void *hcpu)
-{
-	unsigned int cpu =3D (unsigned long)hcpu;
-
-	switch (action & ~CPU_TASKS_FROZEN) {
-	case CPU_DOWN_PREPARE:
-		octeon_wdt_disable_interrupt(cpu);
-		break;
-	case CPU_ONLINE:
-	case CPU_DOWN_FAILED:
-		octeon_wdt_setup_interrupt(cpu);
-		break;
-	default:
-		break;
-	}
-	return NOTIFY_OK;
+	return 0;
 }
=20
 static int octeon_wdt_ping(struct watchdog_device __always_unused *wdog)
@@ -531,10 +515,6 @@ static int octeon_wdt_stop(struct watchdog_device *wdo=
g)
 	return 0;
 }
=20
-static struct notifier_block octeon_wdt_cpu_notifier =3D {
-	.notifier_call =3D octeon_wdt_cpu_callback,
-};
-
 static const struct watchdog_info octeon_wdt_info =3D {
 	.options =3D WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING,
 	.identity =3D "OCTEON",
@@ -553,6 +533,7 @@ static struct watchdog_device octeon_wdt =3D {
 	.ops	=3D &octeon_wdt_ops,
 };
=20
+static enum cpuhp_state octeon_wdt_online;
 /**
  * Module/ driver initialization.
  *
@@ -562,7 +543,6 @@ static int __init octeon_wdt_init(void)
 {
 	int i;
 	int ret;
-	int cpu;
 	u64 *ptr;
=20
 	/*
@@ -610,14 +590,16 @@ static int __init octeon_wdt_init(void)
=20
 	cpumask_clear(&irq_enabled_cpus);
=20
-	cpu_notifier_register_begin();
-	for_each_online_cpu(cpu)
-		octeon_wdt_setup_interrupt(cpu);
-
-	__register_hotcpu_notifier(&octeon_wdt_cpu_notifier);
-	cpu_notifier_register_done();
-
+	ret =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "watchdog/octeon:online",
+				octeon_wdt_cpu_online, octeon_wdt_cpu_pre_down);
+	if (ret < 0)
+		goto err;
+	octeon_wdt_online =3D ret;
 	return 0;
+err:
+	cvmx_write_csr(CVMX_MIO_BOOT_LOC_CFGX(0), 0);
+	watchdog_unregister_device(&octeon_wdt);
+	return ret;
 }
=20
 /**
@@ -625,22 +607,8 @@ static int __init octeon_wdt_init(void)
  */
 static void __exit octeon_wdt_cleanup(void)
 {
-	int cpu;
-
 	watchdog_unregister_device(&octeon_wdt);
-
-	cpu_notifier_register_begin();
-	__unregister_hotcpu_notifier(&octeon_wdt_cpu_notifier);
-
-	for_each_online_cpu(cpu) {
-		int core =3D cpu2core(cpu);
-		/* Disable the watchdog */
-		cvmx_write_csr(CVMX_CIU_WDOGX(core), 0);
-		/* Free the interrupt handler */
-		free_irq(OCTEON_IRQ_WDOG0 + core, octeon_wdt_poke_irq);
-	}
-
-	cpu_notifier_register_done();
+	cpuhp_remove_state(octeon_wdt_online);
=20
 	/*
 	 * Disable the boot-bus memory, the code it points to is soon
--=20
2.10.2
