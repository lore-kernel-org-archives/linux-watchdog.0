Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F69C494801;
	Tue, 13 Oct 2026 06:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791871633; cv=none; b=GRLx/5N7sbhAPwMWV92EPwUN9944OeQigGdMHaRYLVT3QdPTGs/0S0t2MBFUtQJYLa/yMkzx0FIN8CFpv854PZ83eeyVHpersbnO+SqCxx0p5Lg491ibwQSC4tLehabPu5DaHgYAHW/8SzMUx4MT5gKHsdqy9R73887MtKfG9CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791871633; c=relaxed/simple;
	bh=fH9Kfvz9BxN/X6lf8vavcMwm5AFooycimNuX17Ck7qg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RriNAK/pVCnB260MdYRw/31uonNrS0mkjxoegMLzP+i3Dhu55M/4tm0aU4bcEgNiKZNAb1WL+LznSnjk7LI5jwydU1h7WoAgQdtHdeXRjAzo89dQ12Y7grmv/UKMN8hOogyvy8RQpMqeX6CmkBLrIn2EOaWUJ4fY2qWI+Nw+PaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMOM4yp4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMOM4yp4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6FD70C2BCFC;
	Tue, 13 Oct 2026 06:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791871633;
	bh=fH9Kfvz9BxN/X6lf8vavcMwm5AFooycimNuX17Ck7qg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VMOM4yp4A6QizZuk3wknhJpL/6ujyleEiGKSacPYRuXsLoxYgoiPhkOxMKFBIR2Ni
	 JaKx78vHZdqayMbSDaoHiYhlYXxHZdRkNMP8jqHx+6AoFkTgV0+OxCR93q/w68UOfC
	 1BgmfT3QtP6bqI6bczJhY0Tqb29A8No7Rs5RQx3qyYifnOcJE3TrcRxpUXVqKxK61p
	 bzbFTiRHtERdwhAc8AH8UR486Euc2kd/UORWp7bStmTAblqtNOxs1Z8jYE/caUDtWM
	 tzs6dMp5V3ZwVRZQh6JwrBKaeSJXMrU+JXnr/jjrXpuOt0KJpB3XPsTknsDWPU94Wt
	 PQP2s3l/JVIiA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E526CC6B10;
	Tue, 13 Oct 2026 06:07:13 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Tue, 13 Oct 2026 09:07:20 +0300
Subject: [PATCH v3 10/11] ARM: multi_v7_defconfig: Enable Cortina Systems
 CS75xx GPIO, I2C and TWD watchdog
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-b4-cs75xx-s2-v3-10-181bb0d23f4c@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791871630; l=1224;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=MUeH/IRw5kyuG0JD1ac38OtCmIzMZqOUsJQbjBgyrHs=;
 b=7EmyL55x3Rnn+bXyxQnbgQwA99GuF6Rfdq9TG4PEDEP/Z4ODh5ZVbrPWF2BJOohCgEM5ZCq+8
 lAHIz8YPup0AANbe1oRojUNgYOCCfSXKkiKnOQmoKkadQgukyjGEXhV
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com

From: Fil Dunsky <filipp.dunsky@gmail.com>

Enable the GPIO and I2C drivers of the Cortina Systems CS75xx SoCs and
the ARM TWD watchdog driver, which is needed on the Securifi Almond+
because its bootloader starts the watchdog.

Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
 arch/arm/configs/multi_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 23f144359..9a161f8bd 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -423,6 +423,7 @@ CONFIG_I2C_ASPEED=m
 CONFIG_I2C_AT91=m
 CONFIG_I2C_BCM2835=y
 CONFIG_I2C_CADENCE=y
+CONFIG_I2C_CS75XX=y
 CONFIG_I2C_DAVINCI=y
 CONFIG_I2C_DESIGNWARE_CORE=y
 CONFIG_I2C_DIGICOLOR=m
@@ -492,6 +493,7 @@ CONFIG_PINCTRL_QCOM_SSBI_PMIC=y
 CONFIG_PINCTRL_RZA2=y
 CONFIG_PINCTRL_RZN1=y
 CONFIG_GPIO_ASPEED_SGPIO=y
+CONFIG_GPIO_CS75XX=y
 CONFIG_GPIO_DAVINCI=y
 CONFIG_GPIO_DWAPB=y
 CONFIG_GPIO_EM=y
@@ -568,6 +570,7 @@ CONFIG_UNIPHIER_THERMAL=y
 CONFIG_DA9063_WATCHDOG=m
 CONFIG_XILINX_WATCHDOG=y
 CONFIG_ARM_SP805_WATCHDOG=y
+CONFIG_ARM_TWD_WATCHDOG=y
 CONFIG_AT91SAM9X_WATCHDOG=y
 CONFIG_SAMA5D4_WATCHDOG=y
 CONFIG_S3C2410_WATCHDOG=m

-- 
2.53.0


