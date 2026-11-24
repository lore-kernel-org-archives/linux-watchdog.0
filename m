Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795496486;
	b=1UN3AR/r49oBnDlxP1mV3iUQn1QzCgS2/LeNsSsXWv4n8hlKeito5R8usXG8i5zgDAxL
	 TdzdEvbieJXlQLimgrVbDWvzC9kxocqAN8iytqSgxYi1iItAnZDXnlDxHujiy2WKwNM8a
	 dxBxj0pCFqXieuYdlYuVE8v7L4gNu2THrtbkD8KEpaSw85fbzTvTAgZPMGqPzYx3svCK+
	 0QMAqGsVtzh9Y6I9FGxYNwFPLK5bMN/dAkxgMYrwvdhGG3mrwmubXP0KbK5YuCVglXU5M
	 2dvtyVTUnqlXnrI5O2GvwH9HspiWD4uBuX4soa+c+ub+4zkYPq+VSRsejE/VqYL0jVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795496486;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SpABV9aKqp6smud8Wfu98a7VX6J5hPF06e5DetAJnC8=;
	b=LRaXn5/JgyE5yBdcwLZ8M5FI7SKbm6YTyQ/a3T8JMeKIvqsv2Q6W6V3e8VcBWKsc+RyW
	 s6vZyjCFhPrRuDyowAaZX76Ght7UG3Q4tsMf3gRk0IWFxAu85CVkRWhpLT0iSk2a3Dmem
	 07Zsy6vqS8/3go5XjPIUdsnCwgJh4/S30iT0BBWdsd/MSuPOXZcGpdvsc5VkgZXKkNOI6
	 OzPSkI59hR6iUu2zkXpssikF7kzpy0SQRJt66ktrMAmL9q1jLsqyYtLzmO8AEn+8nZpbe
	 29ep+/46e3oyULLlZKxoKAaAbprhR1qWH9Q0wddH+ppeDoH3t1zPQ5NhGSzgFpac1jA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kiTuZlf5;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B92E606A33D
	for <linux-watchdog@vger.kernel.org>; Tue, 24 Nov 2026 05:01:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B92E606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kiTuZlf5
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4bb9d8e8e90so11538475e9.3
        for <linux-watchdog@vger.kernel.org>; Mon, 23 Nov 2026 21:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795496484; x=1796101284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SpABV9aKqp6smud8Wfu98a7VX6J5hPF06e5DetAJnC8=;
        b=kiTuZlf5E9gkEl0zpKfnaUwlFCPbBI/X8mc9mf/rp6Q+KzKRxRQNm5aoSgmhHF8hyr
         EP0QeMBmCe/gmVUZkPYNIx3ttCLhaiKAFfMRiNZmw4BDSJioK+NhAZvw3hYwq3h3Dqru
         eVmRqxmZ/KoSXO0OWipEOutNvMJmw3sYs9h/2lBeWEfSl2usDxuuLZpBNtkKNWRoNsqF
         1TNqwp27o4ywTLakbf12Gd3XMlp6sKXLvRBBCpvNSEBjoybzHbluCXoxRG7gf0Tb96sQ
         fRGN07sshGxYtYNgdhqJHiCAsAJAnbKoMsytfo8W5f7qEGYO1zDO+qyqpm/CJ0wu8nZE
         ENoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795496484; x=1796101284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SpABV9aKqp6smud8Wfu98a7VX6J5hPF06e5DetAJnC8=;
        b=I/z+vI5FvSV0VDeMBBvfiSCsaxY15m3JKdujs1xgZRIYZs1L7E4Gj/5jv8D0ZuvgwD
         od+AcYBZ2Mt4gUvTB2KiTvgYRpQjAsbs/JGUivjhdRU7ZRITZ/QnoqV0pg1QMof2gJ8s
         xXpvkdFvLIpT+ulpMASRTjMUcrePFKRrf377dAGqcnuswIiWSKiBgsYWaogpkS78UALe
         5ftWCg+r0OOlavvTVhnP1yt6/0S34WVelTPqHhgf1sMBLJy30xokrXPkJ1BcyucK95LF
         +Bb9nvybb/VppypBfDSkA0El+CihEWqVGLlD7fUuKb46ogThrZj1mhoMW8yDa0F4S1G6
         uyzg==
X-Forwarded-Encrypted: i=1; AL+hErH0h7uJ8MZSFHYzZxFU0AF2yrjKF5LFTmqKRR/zetbKp41CSrovvxrXlWvK7djD23Nfdx/YZZHWdRgSjCw8hw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8fF+SIZ4Wd1FQj+iN1Rpd53wTOUsaf+zhIvdbZmGbD4j5By99F
	O4ntmygDy1Y5hh/Ufsm4/yjNg5hQqA9z/MQ4Ds6vpT6hKFn0v5c3xqPf
X-Gm-Gg: AZFdTZd2Ah6b/VIXu1lh6U4zyDfd/hlV29Ji07LHsubTdF4i8df5hojYiVRkhzApfEE
	3ND3YnxHXYgpMgCtgLCy/ExEL8+bM/iJXEnEY78cLDCLAL7x9fSVmGJaTZKpJqKGToNV39gRB+E
	l1I7Vl20nFIOBJCZEuZ6PpzJ5erUxai3NBBMjBNKPNXWmwSespHmE/KzPT9VSaFgVP5Rgn0o2A8
	IwpYQlv35kljJ4vuWXq2h4gnks7GXCk7RD95rrDxUEYx5BZ9I8I5HK8MM+iQyeWUl9rMZ4rSkv0
	4PVBV/gmQMcIfVp16AobW0Emzhn3cX0X45XgtYIjvOzZRZRYUmnwT0+NJaLQrORDbyJW8ZlFtqM
	hLsM0R6PV9DuzBQvPdIlMIlm34JZhQ3Wl51sjN/1V0J78I07lD9rUj2QxiB5mQAyQyY7nc8PAKE
	EUUqM63aA67gEo9bt44qVDJNcEIv6yYWU1F0JLwlK79rjkV4MJrfgumySJ3G13jIMT8B/FwMNjW
	Fr6NpQolWXqfMOCfLm/B+JU36ShlSDItMqmlq/uAM9+J7MqsnmJpH1ax+msoTeLgexDxxbgMZMH
	SxSSPSQpgBisE0qqOwHCs8ui58goNFn8cThNRqIqxQgf9V4ZNxa4BR0rDMdPOqpOarvgqtyQLfO
	t6t0lJIockJHCQT+fBg65Da9VwrCABBKHMg6O26Phn6ow5l6G47SG4sdgJRMR52HuigKT4tK9OU
	41unLcwVOfukjRI8uOXGKvIKY4cfKd3tU/1nOLitjCW6mwrumyp5aq
X-Received: by 2002:a05:600c:674f:b0:4bb:56bb:1196 with SMTP id 5b1f17b1804b1-4bb8880fb9bmr266365245e9.23.1795496484431;
        Mon, 23 Nov 2026 21:01:24 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a00-1028-8388-a84e-f512-85ee-fdbe-0621.ipv6.o2.cz. [2a00:1028:8388:a84e:f512:85ee:fdbe:621])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88442693sm353489155e9.1.2026.11.23.21.01.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 21:01:23 -0800 (PST)
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
Subject: [PATCH v4 3/3] powerpc: dts: turris1x.dts: Use wdi-gpios for the watchdog
Date: Tue, 24 Nov 2026 06:01:18 +0100
Message-ID: <20261124050118.87944-4-pepe.schlehofer@gmail.com>
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
Content-Transfer-Encoding: 8bit

The watchdog node passes its WDI GPIO in a gpios property, which the
maxim,max63xx binding does not define and the max63xx_wdt driver does
not read. dtbs_check reports it for watchdog@2:

  Unevaluated properties are not allowed ('gpios' was unexpected)

Rename it to wdi-gpios, which the binding defines and the driver reads.

Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
---

Notes:
    Changes in v4:
    - new patch

 arch/powerpc/boot/dts/turris1x.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/turris1x.dts b/arch/powerpc/boot/dts/turris1x.dts
index dff1ea074d9d..494a96a1f78c 100644
--- a/arch/powerpc/boot/dts/turris1x.dts
+++ b/arch/powerpc/boot/dts/turris1x.dts
@@ -363,7 +363,7 @@
 				 */
 				compatible = "maxim,max6370";
 				reg = <0x02 0x01>;
-				gpios = <&gpio 11 GPIO_ACTIVE_LOW>;
+				wdi-gpios = <&gpio 11 GPIO_ACTIVE_LOW>;
 			};
 
 			reboot@d {
-- 
2.54.0 (Apple Git-157)

