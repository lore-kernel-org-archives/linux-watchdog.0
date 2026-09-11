Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3B915665C
	for <linux-watchdog@vger.kernel.org>; Fri, 11 Sep 2026 11:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125482; cv=none; b=QNrJsFu//ZamWbRv+KfWCJrmcg02vqvFE7blQPbScXQFT+uNn+mG4e1ntcygVzzBLpX450lC8YG3KAAUwppcojG8LWYfRyT43V3UpYrfKbPJMHPAeb4wz9vID1DVphrcED7vUfqnBhWHzXev0A7lUTPR7GIvMcNtL8SF2FG45lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125482; c=relaxed/simple;
	bh=fDZDTRI+aWu5LN17RJSF5MWiMpzqvK3NEpOcipYYhvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KVTQjKy4m1oLvPo8qH0C221XWp6jzsEV4GV36EUI5hLm4W/2NAsDBWT3lEajbBUgKzGLeqF0saBfyeZGsI3/n0DlohAyBpPqj0Wr3NEE3cGnaosr2++uX5XWKdnMRu4VSRCNrdvlKvc051xPNbe62+mYrZzxwG2H8LuEfs11jn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r/tazKqH; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r/tazKqH"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4843e9c5960so723250f8f.0
        for <linux-watchdog@vger.kernel.org>; Fri, 11 Sep 2026 04:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789125466; x=1789730266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MZ6D51q/BQlK7MtFm054nWG9+DWDS+0mGNHkgeO5IsQ=;
        b=r/tazKqHQZjNLTW/Un2DkbLqNpel8YAooFL77376x5Z70WVE+bmc5f1fHER86XCRD5
         NFfx9KaQu7Umg6mf8Nd+0xxGGClz7PbAIOkPSZ9GAD6dnJ28au9jixEMJw9YEBja3q9Z
         V5ptaG1XUpjKaNlH94BNqrY6u+wyuTTJDIz8OB2n040hb91aNnvix+ayb+60PeTAiGjw
         tScOrnN216Abizhx/oCAeClpuBEONmvnM2gJVDUbz5sIrAo5we5DW1cBj9xtyhDtYElc
         y7XRViZlC1ZO/tCEW84hxkbQzISNYGfvsowKyIWaIkP048rdQ4V7yYjX/VlyZpUb1i58
         gFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789125466; x=1789730266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MZ6D51q/BQlK7MtFm054nWG9+DWDS+0mGNHkgeO5IsQ=;
        b=Qr8ruz83535C+q7N7VGVW6rLXp8URIet1g6GohL6fKGvAOCxf1KAfBzCX45UY4mnjQ
         mC+TvTEpiEpkhzcXQJSLc6pWX99sg7rk8ulbfxIqE7FzwdiMbe0iofEktrScrKY0ZgRr
         Z5U8YYxQpyE6BTSP9ody27Q3kKefCddkoLvPzRoUyWfnJh3sqaiUueVwT/G7rRt6UfP0
         T4cnOhL38lw2WHmnYa9WskyT73fmXBRmg65WE6P8PARpzutLTxWWFsw5S7UGPQX3oUh0
         bzJB4XMvHUA+ooLxe2w/LJF/QbrNVHMOP6ugOtFPdLLsAtc+ztdAxCNHX9wv+8gCpbIg
         B+EA==
X-Forwarded-Encrypted: i=1; AKwUvByE0tGPAZ7x7BWQF022FlybohJdBBe6rQX0a2DyrSExNuctVM9/u6Qlq4ZUcxpSsW5QULfxY90WKAQ+u7WJiw==@vger.kernel.org
X-Gm-Message-State: AFuF++kmyybf3R3rzD1A+y3R8vKrPqTdegGIVuBRWShUYZye96XlVQXW
	6s+qoV0UQfZVRwhNZZcVpUjV0fPUVgVqIHRsbDworoiYi8Sm/1pN90ee
X-Gm-Gg: AYBFou3NgcxB+KfuMNFX49PD0a6o4pK0kN+H0iVi3GGn1sB+3auu3L0C647JMDlpmpc
	VMTG68pcVuLv/GwOvcN1iuQSnkjebhyvKf3r7kUoDFQp0xlMltxLAETARFKz+fuctpog8vWk4bz
	V2y17KtEYSQBYvn9W5BFEk0xVLdXKc+fykAAbZIOj01pHFpWChcST4GGQW550xifILgY6qAUesH
	4zDwieLQ2V5C9lOfG1N8NvqRKPxy3DX27tmmXWAyftNL2KFqSxqlILk7q9cpVG0USm+L57H8ZSr
	vfCCc4UuWa9xr2M1wM8cXX0x005DeYrBSaWfyr7/zMAbWRNuZZVTOIqL2c3w6Jg9JUiWgYKSr8p
	tvZ4loipSf8QsNzBumPqcT0xHEs5vUW0XnXwDePzfZVtkW6zXWkmVl3cCZyJZywCIq4ZzvCQs2i
	/yN2zsSx3UGO0g8kEHZqEYv+7gIJHLfPZwcvGG/gIp1Ry1Z6TmsrXO9Ag9ODR9iQuP9O5rZYjj+
	SiyBYQDQGFf8UzGDQ+S4euuVzuneDet42X1LTUlgNmuds8NwrmqogxrSs8OCq3ObDkmRHEZ4NjG
	WiWLXT3NjCTrKzaW1g4m
X-Received: by 2002:a05:6000:18a7:b0:482:de48:c445 with SMTP id ffacd0b85a97d-486eace4fa9mr4203841f8f.11.1789125465635;
        Fri, 11 Sep 2026 04:17:45 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:3de1:9f21:e874:3931])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb2ecf23sm5438182f8f.5.2026.09.11.04.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 04:17:45 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v5 2/8] watchdog: rzv2h: Drop WDTRCR_RSTIRQS define
Date: Fri, 11 Sep 2026 12:17:25 +0100
Message-ID: <20260911111731.3404308-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911111731.3404308-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260911111731.3404308-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

WDTRCR_RSTIRQS is unused, so drop it.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v4->v5:
- No change

v2->v3:
- Updated commit message to reflect the change in v3.
---
 drivers/watchdog/rzv2h_wdt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
index bd86da71b0eb..7c6a4855bd8a 100644
--- a/drivers/watchdog/rzv2h_wdt.c
+++ b/drivers/watchdog/rzv2h_wdt.c
@@ -39,8 +39,6 @@
 #define WDTCR_RPSS_25		0x00
 #define WDTCR_RPSS_100		0x3000
 
-#define WDTRCR_RSTIRQS		BIT(7)
-
 #define WDTDCR_WDTSTOPCTRL	BIT(0)
 
 #define WDT_DEFAULT_TIMEOUT	60U
-- 
2.55.0

