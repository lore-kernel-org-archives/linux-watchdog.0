Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F653BED27
	for <linux-watchdog@vger.kernel.org>; Mon, 23 Mar 2026 18:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774288834; cv=none; b=Hh7WBKx0HmpkeP85X8BF8g+7Fj066EzXzabs9LjIxoHzazNsZ0aZPnN5oKvcoP2rmAyxDbII55aCCk6W7cylGtATz2FpYIUjgxmsjJRXyAaKvc4/+/7A7/uCQ3CJD3uyl0MibikpyO1O6NugljHKyXTVjf5xDGHQVTJ6elzTF3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774288834; c=relaxed/simple;
	bh=E/nHdjHS1PPiOI/cZ5nnAbtoJk9ukFKughnCfizAjOE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=lsCOmu7iuEvV5HcZYQlzeAbzDZtjMlvfrtk/tTTbIJqVIdokRvcNQhDNyK5b2Gc6fJbI+xy7C+8zla7LNeyR7rn0diO5zmIv4BoXJFEIuN5Lzg1tN7tO8ilrlr3Yzi6oLfV70G/4IwCfe3CeV3h0aD044GcNkJFaT3w7Bq7t4n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rhnte2YB; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rhnte2YB"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48702d51cd0so30219385e9.2
        for <linux-watchdog@vger.kernel.org>; Mon, 23 Mar 2026 11:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774288831; x=1774893631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vrYgx725Haq61UFRJXQREBllY8BXNI16WOSLFDeY60o=;
        b=rhnte2YB8mOr4Qz3ufHmKlTqt0uWYk3Ux474yNvcIP/Ii1ujSHY6vZfQ+6hA/nXlh1
         1GEK4KbgVepMWAMXKnMQO4zlpGXsrzK2YaRw8c9CY6iVxRtklA01R6HBqTTU/41utLB0
         IgqsV82JessluQax/ukFqM5DmRGqOXwRGvkViEIzQfwVRyPjtiJ87ym0chDWC7dRjmvK
         fAVPa61OESLl4SkL0Xp5Lin+3qg2KripFNbpENUkceyMnU6HDpTDgsSgF8Uxb3ntPoCG
         WYTBxzqKj7i9WlFe5Z08d9ldeKM19EH7Nrvlu1lBbnUaS2+arZFVhiae97H9ipK+1kcH
         +QBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774288831; x=1774893631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vrYgx725Haq61UFRJXQREBllY8BXNI16WOSLFDeY60o=;
        b=lajMRJ116swRc0nxbJTMz28gpI9kBKyxv46NgGpHmpw1hVsZzfnFIEJaS7TfrP5L5x
         Mg1ygEG8So03zyA28bGj23r30Cqt0i6Zt5VhrSwcHov5AflU0dxPzfVmeeiqcuykKT/S
         cGHlmtgE4DqNbtGIhR/yf3zekBIlyG3eivZLi/kJRhQAihwDkK0s/YZQP3i1CUA6Vwfa
         uEl3144WwGixqZirmbRm7pIqFTk1iQeXGBDO60y+Y9u77RnQtEerMN9lVeItaxuQBmNY
         4M/yY9BejAHIbujGaBkwOxLkDFe2Cyi5ZI5faWm6B9Jc+AJbSYQj++FcX6jK2OsdcPl7
         0Edg==
X-Forwarded-Encrypted: i=1; AJvYcCX2CUWqaXzZsEeh91kgoAmekqlN3aKgnfVNKLlrONkhmY/OIX5d/e58euFoVq1UquCvjtdcclVSOZQGn8pE9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZHyuAljeJBcuRaszX4yaNkB6mqJQqexiDp9fAM3z48M8tZGEt
	BVApXyV3nYd6VX/xX9D7+Rr373XdSgwsEA0AzXNJ7ezuURbirKaFt7sU
X-Gm-Gg: ATEYQzyIPBD4UfWa2qPz181WLbNpmPRPvfWpHuWCqyF+Ci7MOSzHsGcV6JDk5gNO1HT
	pnWq+H0sEt4+y/Ne5misEw2Yqbo3iWG78OIARnh6zKrbsqqotk3ay1ZHeUXdqJcn0+e5SoMbY3A
	Qxa3eRWEx5kuZ/3iWrGiVJWLyqTkrz+U9uYMoapIfPjYDgWoYNMdc/NvM/03RL4KFrmDq+r8n5X
	ifK8BrnHUiSdh1vdf3YnPRo1CCoDhu5316iV6V8oiEgc2AWRBIWCyfI94btVkf360cqP5zyp4Zp
	3PZlxUJF37u3+mIbAzHgP7T6asvKeTiVasG4IVa+4gwTSqC6gq/BuEV2EQCAZEj+65GgHY1rUZK
	lFTgU1vR3MSUFEax7t8TGeTTqNieZ9NXggrOA1gAjM/kCAmpvZKRqXO1kJBWLuIV/EBMCZmvY9e
	KUjdQ/vkUpwpQmiQ2A0Y1ensA=
X-Received: by 2002:a05:600c:45c7:b0:485:3fd1:9936 with SMTP id 5b1f17b1804b1-486fede721amr169762575e9.5.1774288830519;
        Mon, 23 Mar 2026 11:00:30 -0700 (PDT)
Received: from fedora ([82.77.79.23])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-486ff1d3befsm84419925e9.32.2026.03.23.11.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 11:00:29 -0700 (PDT)
From: Eduard Bostina <egbostina@gmail.com>
To: daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	egbostina@gmail.com,
	d-gole@ti.com,
	m-chawdhry@ti.com,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/2] dt-bindings: watchdog: Convert TS-4800 to DT schema
Date: Mon, 23 Mar 2026 19:59:43 +0200
Message-ID: <20260323175948.302441-1-egbostina@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series converts the Technologic Systems TS-4800 Watchdog timer
bindings to DT schema and fixes the active hardware node in the iMX51
device tree.

---
Changes in v2:
- dt-bindings: watchdog: Moved 'allOf' block below 'required'.
- dt-bindings: watchdog: Removed the 'syscon' node from the example.

Eduard Bostina (2):
  dt-bindings: watchdog: Convert TS-4800 to DT schema
  ARM: dts: nxp: imx51-ts4800: Rename wdt node to watchdog

 .../watchdog/technologic,ts4800-wdt.yaml      | 40 +++++++++++++++++++
 .../bindings/watchdog/ts4800-wdt.txt          | 25 ------------
 arch/arm/boot/dts/nxp/imx/imx51-ts4800.dts    |  2 +-
 3 files changed, 41 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/technologic,ts4800-wdt.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/ts4800-wdt.txt

-- 
2.53.0

