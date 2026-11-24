Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795496485;
	b=qNK+/ZmKCZDeiXozLoepYhrPSgsq0sVCQUudulAv69L+PYAfsAcuNSuCHoopbCZ2OURr
	 AklPEnu6a2dJtfexsYOQdXh4Sbo1FnZLapatwjAo9arE+Rj+lV7XlL5moVMlUqatiCkPu
	 iBy9w9UpWEtzjLrVwfEu6NQqXXpI8L+QoWqvp+9H743R8YmY7xRyRF80sSijbqmvH69m0
	 55GlMjLTgRI4wKUAmK9IU8Jb8Gfkyh1bsEsm43+GTqJTfAPzYuWrhE9OAXnZ/CJBcod40
	 GB+ZmKkJFU0oZRlVrjMUywyWa5vTtZ+7csyMvHeaooMvF7U4fDScq8O0yJmYDR4rlXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795496485;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Vs2X3vFXBgQuWTNtNhfJh5Gfnrco9rGsYZYJIbU5LNg=;
	b=c9U89+zTQyJo+e18l5jN68mSLs8QJr0Qni4VyunlcuHgaJyOmwxlKfIqfe3rONhXCouN
	 ztf3UwHQfNWOlpq96OgAMTM1zZsEOyQ+4/hiQua5b/OV+hAf1Jy77/D0V66xu8vhuCM5x
	 CpIpA0C7Hk0ILNEnxWS9EKGIVUA75z3Lt/9gl6lJ+VtppY0xUKTmL+kBfFizLQsHUV9Uf
	 PtSRIcikQthgb4Ldua7CK8hWCf5Le2LWLSqOOGbYR0gMDj0pB8C5l+dG2cwqjOSDPsRav
	 0j2eK4JcctfMPr4edJqLAgkf//kcNCUniy227ExvILH+oRah4I5CQYp0zIlb07o9fNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WuzjfOOG;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ED4606A33B
	for <linux-watchdog@vger.kernel.org>; Tue, 24 Nov 2026 05:01:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8ED4606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WuzjfOOG
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4bb702a7548so32770805e9.1
        for <linux-watchdog@vger.kernel.org>; Mon, 23 Nov 2026 21:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795496483; x=1796101283; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vs2X3vFXBgQuWTNtNhfJh5Gfnrco9rGsYZYJIbU5LNg=;
        b=WuzjfOOGCFqsF4B3uCWv0lke2vzIM9DvBzCEPmRRrrzCd7ohSU3hsTghjaUrgjmfTp
         0E5gMNbVoB2y1lM+yCa+wksZXyC769hqiOYKNJeEAla122fcwpjLQABYCXczYetuPOOB
         889d5I8iH/ON/RgIWF+e8y8WrWb2SjuuHJBb+I0cWD5YohvpMCPQViGqcdS4RaWqzFcp
         sqofC67CEdG7UJwWLcZjZRSkXSsuabAyZ5KlaYbhFyx9gccSAp8zjz76Vp2+wzvVPOB0
         CBbhZbGNlyztzF+qswzGw/Sh6VzK/FcEXgcE3Liud7l0vScsp425Db3eXu5l3B5+gkdR
         tfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795496483; x=1796101283;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vs2X3vFXBgQuWTNtNhfJh5Gfnrco9rGsYZYJIbU5LNg=;
        b=h2Q3rYSHMS5ldiJK49jznMzeUul4THxBffZ/x2Ad0Wwsc3dc6FAQQqTjqU9e63HRCx
         ICEiEvd8z+f3/xakTividFO8/2+yoi5rNYjXHzDu7xWkVBkKS//ZEDWFyC/LvUaQlsRc
         mx3NRAwVvcRp3dbzNnypgFf2zwOb5ZvKhXEp1w/5RRKg3uYYS9abbgG+mvamNasTMfrB
         yQ67lzEYodu7D7zsK0yVU+uKMyZ2kfWnmg7bRIkQGV6Nf9Dlzu37pcxfbnfBRtZFCnZX
         98yjex+z/zOFYnBN+YS4mknMB4Cp3Q6kEPKZJE0XnS/BYnHkvmwg+U2lMo+PgDF8rqGz
         0odw==
X-Forwarded-Encrypted: i=1; AL+hErHyR0rbF0y+9zlLkUd7w57eUpDO5m8+4gzl4QT503zvZ6sv4pm730FD3TNu73+2B2NVDybPi8oEMbyVEKYlnQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+jQ30I3nRsp9pjRmFJEGlM/TVtbz9h/kW2bSsCO500w2nnUjFD
	T1szEj3IZK5ZLFHIcrklAoMkJ6zKI1zw1opjA1SFt6bx/RVn9LrcplDv
X-Gm-Gg: AZFdTZeXhD7nfAbHf/j/9x8xuNt7etn1jX0QHAl80fxL0cxZrdXUAT+Yv2IMdKwvsD8
	QJOMvIFFyLf2ak+MH4IxySG680c5u8gsjVjkKS+Ww4d84XqE1P7JXXJiPaXbIPeDtmIEn6lGoP7
	IM+dspj5vIl77dPHvmn9NRi1ZXmjC9ZlWQ8ta6H7njlva0vjhtn1vWbY7iGZ5tJNdBO+Dl253h0
	nsGx2mzu7kQgpRmxwEyOICTdALztudWogUY03Y+7c4FQZX0CUCLywwmkJx4/NmvPJpA1h3Dd7+u
	kAzRvSlcXMQhG0URF+QCdyvW2XQACe04q+ttBz/5iB5BqTpLqHC5YQPaPoFUBFl0ZV1KiKL74VK
	SNC3x6bVJWcsnBxLczUvIC+19FaHLWBOtxzBNqZnHziCbS3p583IvocJ6rqOX6K7+EmuHzZgc+7
	Yqn0qgaHJkhUC8YAde1VFqTP/s8O8W9uWUSEFgz6u6YsPycBruJEo/FQy6+SQ/vOiljFrXdt8+i
	EvsYhhKt7ODQyEFpxeJFeEb20j2Tre9u3630+3zaZ7cHAzlq6bvcd5XCdxVS5HLxaVDyH94RkPy
	D690tRqpXgk18ncp7WgkFeiQV/IaUYB/giDUz+KyQwXINpIkf7vcJsUr3v+B8o2D6b8lZuoZt0R
	c0MIl410x2kDrXHu0SXtFGiqVBRKPBl5M9yxhX8yuM1M7MEAhK4y8/PueaO94ESHq/YEqQxtifx
	GAeJ/M7cgpfNQsL0saWwpeM8NMafL5vgugkYSONLDMPYHRktybJJY3
X-Received: by 2002:a05:600c:4515:b0:4bb:659c:b8db with SMTP id 5b1f17b1804b1-4bb88813b27mr278328245e9.12.1795496483167;
        Mon, 23 Nov 2026 21:01:23 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a00-1028-8388-a84e-f512-85ee-fdbe-0621.ipv6.o2.cz. [2a00:1028:8388:a84e:f512:85ee:fdbe:621])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88442693sm353489155e9.1.2026.11.23.21.01.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 21:01:22 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] watchdog: max63xx_wdt: Add support for specifying WDI logic via GPIO
Date: Tue, 24 Nov 2026 06:01:17 +0100
Message-ID: <20261124050118.87944-3-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261124050118.87944-1-pepe.schlehofer@gmail.com>
References: <20261124050118.87944-1-pepe.schlehofer@gmail.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pali Rohár <pali@kernel.org>

On some boards the WDI (watchdog input) pin of the chip is connected to
a GPIO, and only the SET pins are mapped to the register.

Take the GPIO from the optional wdi-gpios property. When it is present,
ping the watchdog through it instead of the register.

Signed-off-by: Pali Rohár <pali@kernel.org>
[pepe.schlehofer@gmail.com: use wdi-gpios, request the GPIO as an output
 with devm_gpiod_get_optional(), ping without the lock, include
 linux/delay.h, update the header comment]
Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
---

Notes:
    Changes in v4:
    - take the GPIO from wdi-gpios
    - request it with devm_gpiod_get_optional() (Tzung-Bi) and
      GPIOD_OUT_LOW. v3 passed GPIOD_FLAGS_BIT_DIR_OUT alone, which sets
      no direction
    - ping without the lock, with gpiod_set_value_cansleep() (Tzung-Bi,
      Guenter)
    - include linux/delay.h (Tzung-Bi)
    - print the error once (Tzung-Bi)
    - say in the commit message that the GPIO replaces the register for
      the ping (Tzung-Bi)
    - update the comment at the top of the file
    
    Changes in v3:
    * Use gpiod_set_value()
    Changes in v2:
    * Usage of dev_err_probe()
    * Fixing assignment of wdt->ping
    * Remove clearing of wdt->gpio_wdi
    * Move YAML change to separate patch

 drivers/watchdog/max63xx_wdt.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/max63xx_wdt.c b/drivers/watchdog/max63xx_wdt.c
index 9e46b86b9b20..482cf9f6bd6e 100644
--- a/drivers/watchdog/max63xx_wdt.c
+++ b/drivers/watchdog/max63xx_wdt.c
@@ -7,8 +7,9 @@
  * Copyright (C) 2009 Marc Zyngier <maz@misterjones.org>
  *
  * This driver assumes the watchdog pins are memory mapped (as it is
- * the case for the Arcom Zeus). Should it be connected over GPIOs or
- * another interface, some abstraction will have to be introduced.
+ * the case for the Arcom Zeus). The WDI pin can be connected to a GPIO
+ * instead. Should the other pins be connected over GPIOs or another
+ * interface, some abstraction will have to be introduced.
  */
 
 #include <linux/err.h>
@@ -18,6 +19,8 @@
 #include <linux/kernel.h>
 #include <linux/watchdog.h>
 #include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
 #include <linux/io.h>
@@ -50,6 +53,9 @@ struct max63xx_wdt {
 	void __iomem *base;
 	spinlock_t lock;
 
+	/* optional GPIO connected to the WDI pin */
+	struct gpio_desc *gpio_wdi;
+
 	/* WDI and WSET bits write access routines */
 	void (*ping)(struct max63xx_wdt *wdt);
 	void (*set)(struct max63xx_wdt *wdt, u8 set);
@@ -155,6 +161,13 @@ static const struct watchdog_info max63xx_wdt_info = {
 	.identity = "max63xx Watchdog",
 };
 
+static void max63xx_gpio_ping(struct max63xx_wdt *wdt)
+{
+	gpiod_set_value_cansleep(wdt->gpio_wdi, 1);
+	udelay(1);
+	gpiod_set_value_cansleep(wdt->gpio_wdi, 0);
+}
+
 static void max63xx_mmap_ping(struct max63xx_wdt *wdt)
 {
 	u8 val;
@@ -226,6 +239,13 @@ static int max63xx_wdt_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	wdt->gpio_wdi = devm_gpiod_get_optional(dev, "wdi", GPIOD_OUT_LOW);
+	if (IS_ERR(wdt->gpio_wdi))
+		return dev_err_probe(dev, PTR_ERR(wdt->gpio_wdi),
+				     "failed to get the WDI GPIO\n");
+	if (wdt->gpio_wdi)
+		wdt->ping = max63xx_gpio_ping;
+
 	platform_set_drvdata(pdev, &wdt->wdd);
 	watchdog_set_drvdata(&wdt->wdd, wdt);
 
-- 
2.54.0 (Apple Git-157)

