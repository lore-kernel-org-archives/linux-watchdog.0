Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC2242BEBC
	for <linux-watchdog@vger.kernel.org>; Thu, 16 Jul 2026 16:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784218805; cv=none; b=fXXoBbkUE6l+CObz/K/3o9D7HeBGVEKJ3q8+/0ikRvkvxyrlNmfs0qs65pe2bHJDyCY3suJfrNzxo28nxa944LoL7p/eoDqdCzc99HEIG9CPdsGuvkZLlrjX+fQNRG6Qf0O2xr7OnQyL4pjW2l/kG9PPYA+Wra3kGAAXAnDES08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784218805; c=relaxed/simple;
	bh=uFiZx7lwOslWSHJWY4z9JU3G9Kk7vQ6mMem0n1bGoYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EAEvjROaERHjArcv2kPVCV4/bwk4674eORMWSBLeHom5rL+dJ4u8axBPClO2SdP9virpb0YxDNbVUDp89yfOTvN3aXXIrhhhrh3JSwHl7eg75jfhofyIeDOKrZXIcpLPfGv9/H41mV4zBOk8wRiL27v1R64Ir4ZUXHMe9mwggaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dl4kuD2F; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dl4kuD2F"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-845b6d9bf39so857386b3a.1
        for <linux-watchdog@vger.kernel.org>; Thu, 16 Jul 2026 09:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784218797; x=1784823597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7KAndNulGWhi7VX32166S+y+iqFsKuw1F9eHZj/FgoU=;
        b=dl4kuD2FqtBbKkKkh4vxNbkh+rW4Akj3KDBCrPOnUw8BNc7qXKc9iyvBUkHPnWRHYZ
         khb0/4e5uwfyOk0kdPhPRZdOMr6cmSpvHmW0AspELsike/IR3ei43ObhTUcNSMuu6zi8
         LdX8Lycvp7GYr8rnh01WpgjbbhvYllHiAYEaymaOmJoVZ41gyanMv/VWhtBH9W2X0TCG
         tjLK/Bv7O2GxsN1W13cSaXHXDnb09ZB7/89gs6JWQcZaDMk7mHckFGrGTG0GHxbB8dYZ
         Z5bnhYtoXczbwG2GfQE/vY1SvrJumbtC2oAqFFJMEotldOeXzvlWP9R2YI/y7eYIWNho
         q0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784218797; x=1784823597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7KAndNulGWhi7VX32166S+y+iqFsKuw1F9eHZj/FgoU=;
        b=lOBdBZyQepBJH4W3JIN8lI+kwnnx28pkC5cmBPnKzRJFbFA0NZvKCJzR48vbikX8p3
         EYFCtn4LzbhHUuLbVHy+sQaXt1zXCAOHeAuE2VLyPLku4T42pwEzVDee9ozw1CiJZta5
         YZugn6n/CV1v9Xc+WpwsjzPHWEXNK1usXuX4iDLIDcjrV0WMVx/dmuGlDUkIhee6vfqV
         kfmsYf4VbrlteQw4xOm6hoe+dE4gAcgnmjL4PUS0X5b85YuMIghT72Lba05X3N8grfmw
         irCZh5gtdAL6B+HP279kqT/yxHv1bkn8yQC+hWekeUY3QCv6aQZr0aZb39xoESC2aauy
         ijPg==
X-Gm-Message-State: AOJu0YxBEhh6+dEor4El4ZkJYgTTvP+gBkJcjcKIGjPhpriCeAQ5JSLv
	5LcCxyrlYqmdKL8wlNCsrrCZln6EW8ghbmqm6XJ78IDsiOFz5pOI7FYJ
X-Gm-Gg: AfdE7cnwgE/wECz7/jgo2wnLuG0BYZkXx5l9aI3KTwREwN+x27SOFCxTz2iAHecJA/i
	/wr9X9q7iZN4Lc8gooN+crPy9vMzvN6fMLCPn6mxI8MdBQuMlel9Nj97XHggZDksyPle8rbaLsp
	hf0Cc91l35uTt2OyNyMgMx2um+75EtyH8zSs+8hgxreV1zQ4unWxhSDTbwf0kmWBc+0QSO9MlHL
	rG80le2yI22qK2v+YPGROMQd3r6SqdAfsEgN4f0YOaa32+5vDX2O7tEF8dkJF0fCRQJ4ylmJ0ix
	txqWA74yGRN6xY6L/KiaxQGOD/9v49pfvrHbBeCLnacIYmirdEEbzVNvBjOYjywvEm1589BWsoS
	Tedtu78xZtv1pU/dS8XhEk0uMoIiSyf2lQ/1ZM/sROWCGgJBD+zf8Mx0pr1jF6Yima7805jTpA8
	3jqUNrFHpcEHZyw3XoekuEXF2io2JJhr8O1w==
X-Received: by 2002:a05:6a00:3c8d:b0:848:2a69:97be with SMTP id d2e1a72fcca58-84beb1a539bmr3230781b3a.10.1784218797312;
        Thu, 16 Jul 2026 09:19:57 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f23a600sm5092661b3a.6.2026.07.16.09.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:19:57 -0700 (PDT)
From: Akari Tsuyukusa <akkun11.open@gmail.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-watchdog@vger.kernel.org (open list:WATCHDOG DEVICE DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	Roman Vivchar <rva333@protonmail.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>
Subject: [PATCH 5/7] dt-bindings: reset: Add bindings for MediaTek MT6589 reset controller
Date: Fri, 17 Jul 2026 01:19:21 +0900
Message-ID: <20260716161923.266315-6-akkun11.open@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716161923.266315-1-akkun11.open@gmail.com>
References: <20260716161923.266315-1-akkun11.open@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add MT6589 reset controller bindings.

Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
---
 include/dt-bindings/reset/mt6589-resets.h | 25 +++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 include/dt-bindings/reset/mt6589-resets.h

diff --git a/include/dt-bindings/reset/mt6589-resets.h b/include/dt-bindings/reset/mt6589-resets.h
new file mode 100644
index 000000000000..18ef729022a9
--- /dev/null
+++ b/include/dt-bindings/reset/mt6589-resets.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2026 Akari Tsuyukusa <akkun11.open@gmail.com>
+ */
+
+#ifndef _DT_BINDINGS_RESET_MT6589_RESETS_H
+#define _DT_BINDINGS_RESET_MT6589_RESETS_H
+
+/* TOPRGU */
+#define MT6589_TOPRGU_INFRA_RST		0
+#define MT6589_TOPRGU_DISP_RST		1
+#define MT6589_TOPRGU_MFG_RST		2
+#define MT6589_TOPRGU_VENC_RST		3
+#define MT6589_TOPRGU_VDEC_RST		4
+#define MT6589_TOPRGU_IMG_RST		5
+#define MT6589_TOPRGU_DDRPHY_RST	6
+#define MT6589_TOPRGU_MD_RST		7
+#define MT6589_TOPRGU_INFRA_AO_RST	8
+#define MT6589_TOPRGU_MD_LITE_RST	9
+#define MT6589_TOPRGU_APMIXED_RST	10
+#define MT6589_TOPRGU_PWRAP_SPICTL_RST	11
+
+#define MT6589_TOPRGU_RST_NUM		12
+
+#endif  /* _DT_BINDINGS_RESET_MT6589_RESETS_H */
-- 
2.54.0

