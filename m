Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACFF21771B
	for <linux-watchdog@vger.kernel.org>; Thu,  4 Jun 2026 01:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780535162; cv=none; b=ctUCDInxiSzvR+Dk8t6ned22FbPPs29qAZIzvMpHaxjKSDjDr0x+eh3VJbcwdm2b6QLe7wizeUNRdfm29fXdTo1+v4Q3k7tqux3b4NtAnP6nUKEw7HMKQG1Ygm7g1Li1leSh47S8NWPjHe18ZQzJigEQvwR4vQLyGiAXaqkP8Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780535162; c=relaxed/simple;
	bh=eGDi2DJXnKBItl8+HRy9q9JtdCckzBBR/iF39quN9Gc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G40aoejZ4srrLnzs7noc84n2R5G7XAuGjx5+jgRrVt0blC3Z2/4Ur5VCo0HfP9KeGx94ouaMObyfrRTJNS3+eDqoqvBXYqPjvywm7RDB5yc+IedP6atHT8ttuVYH5V+i/o4Kl5aFgiAblnwJoVNdS+Wx1gwB72eYbdAxU3c8EXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfDdSS4K; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfDdSS4K"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36bd175fdbaso69309a91.0
        for <linux-watchdog@vger.kernel.org>; Wed, 03 Jun 2026 18:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780535161; x=1781139961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AyvbjefoxWefiry2TdXlq5HSZ0FcJuLz0Lra0pLvUAU=;
        b=dfDdSS4Ka4oyOYlhCZMaHqM7IA8W3VMPdxgsciNaVuxK/ZK8H9bgfR4cbcSFJFkjil
         S4XsRiOA3s6a+oNtpWEEZGbggBJS2jCXF31eqZ2kuWEsPVV7X1DIW5zAYJJKGEAYDi1n
         rjsvWkrD4+3Auf80JLH5DdI4sEULE8SvLF4X5WSlnSJIf0wt5HgjDreP7KJPBylkIB6n
         ndyW38+qdOa8+R10sZflCjnMBScxbhQw3KsZLnlYcx3ak7euIrueenXC6ub3Finv3nyq
         sCU07EWSgGDmYdopJ/N3bH0V7VUmQgBfQt45tY06BCWkGvlSrkoqYDRM1bgXb0rzVxTt
         1erw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780535161; x=1781139961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AyvbjefoxWefiry2TdXlq5HSZ0FcJuLz0Lra0pLvUAU=;
        b=lYEu4Av89sOQ1fhj6IhoN6z4DIF5mGZ0YrVLFif+CPpja64una8lOVPa3X067VED7d
         gFDNXyMNGAhBNjGemi3H+tc+oET6FcK9x/DwSEAOYmQeDLjlE09Ld+w/yHfQufb+FISh
         2oUtJ3T5mh13tYZHBQ4Ngj5m/mMHyuJtT+S8uKXdQMldQXlgGIgKlTJzdh6HRpgzCCVy
         63NzSLiWE0uJ92xh3itmSAiDHEJ4F9NhcK5hmr8dukAl/TlpxBh6nyZh58+dNXCpFQQm
         jvFlahIATnJ/Rid587DGdCJhZ9AtupUgiVQ7u6Repe3H7aUmuq82IK2a6d2uB++WPxSx
         ISpA==
X-Gm-Message-State: AOJu0YxQtpHNppcQz5qnUQLI7p/oz15il/qH0pg+yI3XPbe2sPVtyt6T
	1aJcQ4LT8u8WAz2ql4CIf6ItX9F6KQN9r7P4k7XytIkXORh2srQ6MuSgS6lEFlUR
X-Gm-Gg: Acq92OF4kiFURYb8yJAMvSgvbYaX+Ucnx0LNBezTBNwck2qCIfURHex2PJ2pXd0TMcA
	B8mI/PC4lHauM4hZVK3mUo+o29SBEb7vE7Qz9jci2J1/jxDO4wz5XN+umE7g5csp+c59b/uC8AE
	bA5OWgukarnfXU3OG+C0jXbsSWlg8qlwvuzG6fl89vY4/6IwBXY8Yj34p41l4lxfcqqebbv90zn
	J8JIoVFXFCmursvLKMcHrfTWXgIta81hi0Ze92DS96CzgyjYcXVB2OKiSFwNsLOfG+MgGG1POOX
	1wo0sppr/n/9ci5mP6XNJMldwnmyRR+wjDVRcsuhv7GP8YIH2S7QS7XLHYRacU8BGzCKHRyhicl
	rIdtValvZ3xatMGFKQjkNCOsyQF/9PpwkOOuei9jTiT9NmuhqUeXEqJPTiHDlsfEtpmxfA5wOsQ
	JXhKrtTGMvhiWoVpv4J17nPy8JkCIGzJWxRTeQzmZAdp4Grp6d8cIVwrWidXIaRVjA96pepb76d
	UpH1MzdN+H6PMUYwpiwLp7MjZjX4QaJnX8wrwwt3kpcAz0mNf/b1w4n
X-Received: by 2002:a17:90b:540c:b0:36d:ee3b:fcae with SMTP id 98e67ed59e1d1-36e3083798fmr5960595a91.6.1780535161109;
        Wed, 03 Jun 2026 18:06:01 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36e6d169abdsm2366747a91.0.2026.06.03.18.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 18:06:00 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-watchdog@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip (AT91) SoC support),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/2] watchdog: sama5d4: fix IRQ and timeout bugs, use platform_get_irq_optional
Date: Wed,  3 Jun 2026 18:05:40 -0700
Message-ID: <20260604010542.23177-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes three pre-existing issues in the sama5d4 watchdog
driver (unsafe IRQF_SHARED, incorrect IRQ_HANDLED return, ignored
device-tree timeout), then simplifies interrupt acquisition by
switching from irq_of_parse_and_map() to platform_get_irq_optional().

Rosen Penev (2):
  watchdog: sama5d4: fix shared IRQ and hardcoded timeout issues
  watchdog: sama5d4: use platform_get_irq_optional()

 drivers/watchdog/sama5d4_wdt.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

-- 
2.54.0

