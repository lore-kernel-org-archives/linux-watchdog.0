Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795554379;
	b=XX7E3bn16OqhKbyfJ7eVqi2tA6G69pA9ySibOM816YDMGHK+PsY8q34XMA4h9eLFayPd
	 p0SqQYozFwBu/GJ3SzH/zIfCZ+m5QoNNLJ8JGw6TbOuZ1jRLsE13npjlyt0OdCE1Tqpq3
	 BhxlSZWth1Z7eO9DjrC8gKn1vIavJmprwaHQVy4BAZdWpnOqO+qWuXitIbyhmwaTgpJl8
	 QMKVa/2DMLWqZCg0uwaKEJtJQo0DPstl1jQVHI0mgcxS4HtRa9cl7eVRxNsKelygNXvSh
	 Jq6hTrvHhcAz8WLDo3WZpepiHvEeYafwqpNlIT616iW23ThSAnQCkoKAdnGF494eiTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795554379;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=DFqtRoWlpuEyjd15AtWg+ti4h6jhp60R6aesuq4S/JI=;
	b=jn8kzUyTEgLTUjCpZSGSK2aJSFd5RFJV+hGN55QvQ5aiX5b2oYF8zWJwew0Li6ARXc51
	 PQHtMgHZ0OFA1MdNGncLtIN4u4IRpvU5++PUSnMhJhYBc+QUxK+SkHH3RcCcZm+Fkfii2
	 jfPMOADZhS7V+ieeKDQrTmZKWiLEwBxa2IPNMLUTlLmvj/TGitZVfF86/j2JCem5X4T6j
	 hx+mWLWAvMDHj8/GqFO4jtbsS30uvscbdMlcGQasMUGUqQ2zbJPA0E2RmWs2QfHaLOmqZ
	 U4uKRqomc0foFfRa8miuIMOSFFg7vGrmXBuuUIx2MhUWpwsygxJG4gb/YGXY6vKTlUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UtaXWhDI;
	arc=none smtp.remote-ip=209.85.167.47
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC296606A323
	for <linux-watchdog@vger.kernel.org>; Tue, 24 Nov 2026 21:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC296606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UtaXWhDI
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5c17ef1e18cso3048268e87.0
        for <linux-watchdog@vger.kernel.org>; Tue, 24 Nov 2026 13:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795554376; x=1796159176; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DFqtRoWlpuEyjd15AtWg+ti4h6jhp60R6aesuq4S/JI=;
        b=UtaXWhDIYZZ/Sk3Wxy8wN58qsij+ZMcfa+6Kd84XXxQKJzlRqjYNgJJ1p4ovwGhFPo
         ULuxf2SJ45Sn+tJQ4UxA8Y+YtgEWNdgEVgp3oh506jILpGM1dBmB4VW5ZYUKKYrzRu1C
         SLCzMK8oESCPpLxw2cYVygvxhlT3Y1Nw0bs0q6mDXx7Kkv8ry4dHVuSkcgSW0QVjPhIi
         iHGbQ0Og9GhxHgoBIlKvvj00eVX50qR+n1uZIfOTdOxsVlhrDDEqG+2iHM9vBEwVArGB
         h5yQNSsdOcwX3Yc2u+AUGqMn6jfFbrlyyNFSs0Pp0KQGHrYxrqs0dGc78GHkWMRaLOGg
         fujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795554376; x=1796159176;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DFqtRoWlpuEyjd15AtWg+ti4h6jhp60R6aesuq4S/JI=;
        b=XdA8STAhPlPMoHjTUTCffh67NiDxWmW16PCUvoNJbgEgRTo/O2855pVpI1O859pePF
         +uWfcdmei7YcBzohF7iMMY2mJRiFshlmdfewEsDZViK9tlsb/Kj8oMEbFzSPm3f2tIKW
         Go+BYaqIBc1lIcmllBWw8jMoYgTRU6QgGss75zBjwoSd+XO3S8d95JbKY9RdRtdH3AtI
         X5fVfJqUb44QWH7vkuU6gi101Cm+J3jM+ARfYYXXCvFJ1gQ9DmCrMy5LnM3yd79cXwFp
         tcypMtgdfuXiXT6eoA/NOLg6soue/X3tlJl/l0fdEvzkKfnTImJLa5jrzdZT5cBFugvh
         xiUg==
X-Forwarded-Encrypted: i=1; AL+hErEhWOt8VJc6BAyzWDIJZPQyaG31qVioVbH5Idk6QGBKl/aHWII4cuRUnxmSdWtg4goPMrscC/k0jQMCAusMNg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8R7Fde0oE3w4LizVMjo8baXJgAQhuk1GjzRhvLJDIMc82modmm
	F+cUu9ao2gZjpaFnskz82AxERqQGFMkbLqar3jegGN/z4nE1WA5nIn39
X-Gm-Gg: AZFdTZdTx3dpOb7N8I0JkiTGY4KQVFXE843Bef/48m6eqaLCk9qsuaMFduPvBppz0K3
	XdSbpVcgFihyDFTwIsz91h7ZMCrNNJtTCJQUOhrqN3iF5JJlGtnlxFNkCOQgJ05Gvqbb99x4vTB
	uC+E8Nyy5EDdfMSuNpKq0wf5c9FmS/paIJaFvjstZ9Y9GAkushPzW0I0+tZKeErNQNR+pGdV86q
	v+bYZo3oi8ja2WpxkdLwKDT9moKCDiJQOq7FwdX6GpQv8mDU3/Uj15icqJ8PgtVV0o9KKXDlTVv
	2vVa2EU28aUbwMX6JoO1gL/g+jUr4qJQc1+Ec1JmrU4k82SmdbKL99ZV/e3mic/LosblTnYfKdo
	rHK15o79YkQWv8z+3D1GOkWTkXcWEw45jxvMPD35rNQP3ScP3aLk5dCm0vHIZH6gJzrVPCK+QLW
	Gs7MSDPbtOc0xWOWlUUKMfIw3leV3XJefhYBVrir6QbtXH1LgnWLlq8CvsnX3uD83DmST9JGqUZ
	8sSuNu7XPWUFattje2qwrycSOb+Tu3aTA/9rqZsoU4q2ZsuKAipM3SVK4FdX35NVSaMeaso9pSq
	H8Ia0bGNnD9z2XY8nrkpvJvd6Rj9yOECzwoPFE2KCpSjACigdDUCcCgTiASTX84=
X-Received: by 2002:a05:6512:308a:b0:5c1:ac75:7a16 with SMTP id 2adb3069b0e04-5c1bc6f69f2mr4451118e87.9.1795554375701;
        Tue, 24 Nov 2026 13:06:15 -0800 (PST)
Received: from [192.168.0.15] ([2a02:a312:c59b:a180:251a:f25f:80fa:af1d])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1bd041813sm4099045e87.53.2026.11.24.13.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 13:06:15 -0800 (PST)
From: Artur Kowalski <arturkow2000@gmail.com>
Date: Tue, 24 Nov 2026 22:05:59 +0100
Subject: [PATCH v2 1/6] clocksource/drivers/timer-tegra: Keep Tegra20's
 watchdog timers free
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-t20-for-upstream-v2-1-440116846f97@gmail.com>
References: <20261124-t20-for-upstream-v2-0-440116846f97@gmail.com>
In-Reply-To: <20261124-t20-for-upstream-v2-0-440116846f97@gmail.com>
To: Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Prashant Gaikwad <pgaikwad@nvidia.com>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org, 
 clamor95@gmail.com, Artur Kowalski <arturkow2000@gmail.com>, 
 linux-clk@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5256;
 i=arturkow2000@gmail.com; s=default; h=from:subject:message-id;
 bh=kW4sEED/6BqJGzvceEYZoUijI+JkmBOyqjWAj+7fmvM=;
 b=owGbwMvMwCVmYeTc/TaVxZzxtFoSQzbrH6d0K/9dzX0997+IaIQ4ng8w9t9V959joolJV/CZk
 24tf0o7SlkYxLgYZMUUWcweCn3hmef1fsPLrZ0wc1iZQIYwcHEKwETE7zAyXE2pjQoWUfDh6el1
 OKAR6ee1xu/p98sPv0xM4ChRiXp1i+F/wNK66h0CTfzT7ZmiGxz0O8vqzp39tVVF6Pm81sVm8zY
 wAwA=
X-Developer-Key: i=arturkow2000@gmail.com; a=openpgp;
 fpr=F60710C8D69E03A01A2801CD87A47D20C2709637

Tegra20 has no watchdog block. Instead, the clock and reset controller
resets the system when the interrupt of TIMER1 or TIMER2 fires while
the previous one is still pending. A bootloader can start this watchdog
and leave it running for the kernel.

Since commit f6d50ec5f85c ("clocksource/drivers/tegra: Support per-CPU
timers on all Tegra's"), the driver uses TIMER1-2 as the per-CPU clock
event devices on Tegra20, where it used TIMER3 before. When CPU0's
clock event device takes over TIMER1, the clock and reset controller
still resets the system if a timer interrupt fires while the previous
one hasn't been handled yet, which resets about half of the boots
early. If the system survives that, the watchdog stays enabled but
never fires, as CPU0 keeps clearing the timer's interrupts.

Use TIMER3-4 for the per-CPU clock event devices on Tegra20, leaving
TIMER1-2 to the watchdog. Tegra30 needs TIMER1-4 for its four CPUs and
its watchdog uses TIMER5, so keep its mapping.

A watchdog left running by the bootloader is then no longer disarmed,
so it resets the system unless it is pinged. That needs the tegra20_wdt
driver, added in the following patches, built in or loaded before the
watchdog's timeout expires. As far as I know, the only bootloader that
leaves it running is U-Boot with its new Tegra20 watchdog driver, which
is queued in the U-Boot Tegra tree [1].

Link: https://patchwork.ozlabs.org/project/uboot/patch/20261110-wdt-tegra20-v2-1-b452b03bedb5@gmail.com/ [1]
Signed-off-by: Artur Kowalski <arturkow2000@gmail.com>
---
 drivers/clocksource/timer-tegra.c | 40 ++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/drivers/clocksource/timer-tegra.c b/drivers/clocksource/timer-tegra.c
index 35b6ce9deffa6..0f63bf8bd7064 100644
--- a/drivers/clocksource/timer-tegra.c
+++ b/drivers/clocksource/timer-tegra.c
@@ -208,10 +208,15 @@ static struct clocksource suspend_rtc_clocksource = {
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_SUSPEND_NONSTOP,
 };
 
-static inline unsigned int tegra_base_for_cpu(int cpu, bool tegra20)
+/*
+ * The timer used by a CPU is TIMER1-4 on Tegra20 and Tegra30, starting from
+ * @first, or TIMER10-13 on later SoCs.
+ */
+static inline unsigned int tegra_base_for_cpu(int cpu, bool tegra20,
+					      unsigned int first)
 {
 	if (tegra20) {
-		switch (cpu) {
+		switch (cpu + first) {
 		case 0:
 			return TIMER1_BASE;
 		case 1:
@@ -226,10 +231,11 @@ static inline unsigned int tegra_base_for_cpu(int cpu, bool tegra20)
 	return TIMER10_BASE + cpu * 8;
 }
 
-static inline unsigned int tegra_irq_idx_for_cpu(int cpu, bool tegra20)
+static inline unsigned int tegra_irq_idx_for_cpu(int cpu, bool tegra20,
+						 unsigned int first)
 {
 	if (tegra20)
-		return TIMER1_IRQ_IDX + cpu;
+		return TIMER1_IRQ_IDX + first + cpu;
 
 	return TIMER10_IRQ_IDX + cpu;
 }
@@ -248,7 +254,7 @@ static inline unsigned long tegra_rate_for_timer(struct timer_of *to,
 }
 
 static int __init tegra_init_timer(struct device_node *np, bool tegra20,
-				   int rating)
+				   int rating, unsigned int first)
 {
 	struct timer_of *to;
 	int cpu, ret;
@@ -297,12 +303,18 @@ static int __init tegra_init_timer(struct device_node *np, bool tegra20,
 
 	writel_relaxed(usec_config, timer_reg_base + TIMERUS_USEC_CFG);
 
+	if (tegra20 && first + num_possible_cpus() > 4) {
+		pr_err("not enough timers for %u CPUs\n", num_possible_cpus());
+		ret = -EINVAL;
+		goto out;
+	}
+
 	for_each_possible_cpu(cpu) {
 		struct timer_of *cpu_to = per_cpu_ptr(&tegra_to, cpu);
 		unsigned long flags = IRQF_TIMER | IRQF_NOBALANCING;
 		unsigned long rate = tegra_rate_for_timer(to, tegra20);
-		unsigned int base = tegra_base_for_cpu(cpu, tegra20);
-		unsigned int idx = tegra_irq_idx_for_cpu(cpu, tegra20);
+		unsigned int base = tegra_base_for_cpu(cpu, tegra20, first);
+		unsigned int idx = tegra_irq_idx_for_cpu(cpu, tegra20, first);
 		unsigned int irq = irq_of_parse_and_map(np, idx);
 
 		if (!irq) {
@@ -376,12 +388,13 @@ static int __init tegra210_init_timer(struct device_node *np)
 	 * after CPUPORESET signal due to a system design shortcoming,
 	 * hence tegra-timer is more preferable on Tegra210.
 	 */
-	return tegra_init_timer(np, false, 460);
+	return tegra_init_timer(np, false, 460, 0);
 }
 TIMER_OF_DECLARE(tegra210_timer, "nvidia,tegra210-timer", tegra210_init_timer);
 
 static int __init tegra20_init_timer(struct device_node *np)
 {
+	unsigned int first = 0;
 	int rating;
 
 	/*
@@ -398,7 +411,16 @@ static int __init tegra20_init_timer(struct device_node *np)
 	else
 		rating = 330;
 
-	return tegra_init_timer(np, true, rating);
+	/*
+	 * Tegra20 has no watchdog block. Its watchdog is driven by TIMER1 or
+	 * TIMER2, which the bootloader may leave running, so leave both to it
+	 * and use TIMER3-4 for the two CPUs. Tegra30's watchdogs use TIMER5
+	 * and later, and its four CPUs need TIMER1-4.
+	 */
+	if (of_machine_is_compatible("nvidia,tegra20"))
+		first = 2;
+
+	return tegra_init_timer(np, true, rating, first);
 }
 TIMER_OF_DECLARE(tegra20_timer, "nvidia,tegra20-timer", tegra20_init_timer);
 

-- 
2.56.1

