Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9016495501;
	Tue, 13 Oct 2026 06:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791871633; cv=none; b=ck4bzhjJsXDD03/6/4UzlZRHS7HwBJkmXKflbV1yS3emqdC3KcGIhMmsq9Hq3c4FxIDpUnKpcY/YKsJ2g715xOC49qAj9QHBPKy+XAV/Df7w2mmXQa64PG6okOOzOSWsu/bvVnsUc+wiwz6ZOfVCROC8r1YJUMZ5K+Y1ofin6G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791871633; c=relaxed/simple;
	bh=Fc3v+sAfUFif61yc1m5RkBfsjoDptWTKM2sW8+Rf9hA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=efHUZg5S+g4n0NRG5MpXAsZxME8GywkDOkJXP0cgzSCubWfTUaRbFXAdpWyyWQmS20LkhyKpjxcGwWA3o/+4Zz/95RCsunIHuTKgg4r/etAaDz7BBhQYsysIpCSgWiBT+OTJrz15Q8KUzYmnWoOZRgFtZ7YLIyqSe3ujzFrnOjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOxo+RwC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOxo+RwC"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8453AC2BCFA;
	Tue, 13 Oct 2026 06:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791871633;
	bh=Fc3v+sAfUFif61yc1m5RkBfsjoDptWTKM2sW8+Rf9hA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bOxo+RwC2zjgRs6qGP7qZErxuLVWITIOpffDalZ/tjcOVVmArYlnrO7BINiW3QenN
	 j+84YyXyqgNf83v3nJGqNIR/KqX4bMsinZ0EhXiKlrAH1/6i7wY5hHjX+w5Kuyn6oR
	 S5Io4HV4H4UgQiRV5k9fdN0nAjtciRlJsaeZURXuIr+E3poPD4DNTC0y/R+hNtgRF6
	 76t5cEqJdEa39cDHfAOPNRZEuYjQhLyxst57SzzTqDNm3HJkBIR5nmAKhsnPh5+hF+
	 rnkF28kcu07/WBG79eWRCp9dvC2YU6EQ+XWzPJxwMQ/pCVM2LXDtKh4jqdNC1mXHhE
	 I4lNfp8Od2F2Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724ABCC6B12;
	Tue, 13 Oct 2026 06:07:13 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Tue, 13 Oct 2026 09:07:21 +0300
Subject: [PATCH v3 11/11] MAINTAINERS: Add Cortina Systems CS75xx interrupt
 controller, GPIO and I2C
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-b4-cs75xx-s2-v3-11-181bb0d23f4c@gmail.com>
References: <20261013-b4-cs75xx-s2-v3-0-181bb0d23f4c@gmail.com>
In-Reply-To: <20261013-b4-cs75xx-s2-v3-0-181bb0d23f4c@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Russell King <linux@armlinux.org.uk>, 
 Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-i2c@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 Fil Dunsky <filipp.dunsky@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791871630; l=1164;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=8born+lqbJWHHfA9yx4+qhsEyHSP/MdbnsbUcNAg5HU=;
 b=cY7nRbylwIRSf1nUA4XDrnz6QFDD2sJTbpyTUXOnmHqlTkMytJ1XteJxUAVr/Q12Pulk67ADo
 67PuPr03UdcDGJIn+pujKPYvhgqfRRNGDcDsMUdG3SePJp+s5ACW89t
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com

From: Fil Dunsky <filipp.dunsky@gmail.com>

List the new Cortina Systems CS75xx interrupt controller, GPIO and I2C
drivers and their bindings in the CS75xx entry.

Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 53f6fa1c5..604993705 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2925,10 +2925,16 @@ M:	Fil Dunsky <filipp.dunsky@gmail.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/cortina.yaml
+F:	Documentation/devicetree/bindings/gpio/cortina,cs7542-gpio.yaml
+F:	Documentation/devicetree/bindings/i2c/cortina,cs7542-i2c.yaml
+F:	Documentation/devicetree/bindings/interrupt-controller/cortina,cs7542-intc.yaml
 F:	Documentation/devicetree/bindings/serial/cortina,cs7542-uart.yaml
 F:	arch/arm/boot/dts/cortina/
 F:	arch/arm/include/debug/cs75xx.S
 F:	arch/arm/mach-goldengate/
+F:	drivers/gpio/gpio-cs75xx.c
+F:	drivers/i2c/busses/i2c-cs75xx.c
+F:	drivers/irqchip/irq-cs75xx.c
 F:	drivers/tty/serial/cortina-uart.c
 
 ARM/CORTINA SYSTEMS GEMINI ARM ARCHITECTURE

-- 
2.53.0


