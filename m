Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1065733FE1F
	for <linux-watchdog@vger.kernel.org>; Thu, 30 Jul 2026 06:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785391581; cv=none; b=ePbIr37Wn5mRlDcBWkNtWxj4X0idJyRFczHEBPCCRYLd0O0loKsZHyuvBbpPg7kiR3rwg2JDg3ORHYRcx/cnN5qqVY/5Vy225jc29xCGdLJlqEo69MoNAeue35of+TROq/hPz2lLO36HBfCHQ6nrnofM6amVNKSyfMsdjoSm69o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785391581; c=relaxed/simple;
	bh=fXpWvlS3WiNkW6wpyTNZG655SLWJmRPd7Dyi0AhaBv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KuICOHWdfuxlyAc+F3qgFhCNbiSFWxjWWl5bno2R2VUIZ0lJhF+B89PxbEttbFdgs6WCqJF9eE01YjWyxfhw0RdkJCrAb7bfo0svp/TpMPQEovf6Gdjowedo9VE9oIKxx6P8A/e6/TPCO+TQC+GmEgdlzbc7L83JUufjLW5Bhbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqUxFp3n; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqUxFp3n"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2caed617615so21443245ad.3
        for <linux-watchdog@vger.kernel.org>; Wed, 29 Jul 2026 23:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785391579; x=1785996379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=70qAmrGbi2lwMLJ48ZAfSmbWQpEbDt5ppwx5wBXbB6E=;
        b=KqUxFp3nXpj6+93AAZs6Wrtx3Xw/zkmH9NGMxcaPp0ZNDjufepBDNoPvUx3q3HRwUr
         yoBt+xNJ7M1m6jWpyxtg9Sscw6qJZLztX1zqgsfQF+BjR86L9Ve19Ol61d0ifvWlhfUZ
         dhhBFqqg1Uo+XfO5r5l1yMJ5D7bKUijEUfLYkZbaCi3iaA08gCxF8vfN6Yl5to2RuFg9
         Qmk+fWRDrpikHIhGtZh4Bz1sa0eSPiKxpTV9haBWbXkFahwAvlV2zY4eJsoQkl2OK354
         HoFkaV6p4/+PqwaIZQqTeBzP0n16VHLeL7D5xXwSTm/42DtdTwZL6egbpWXgAtc44EBx
         pN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785391579; x=1785996379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=70qAmrGbi2lwMLJ48ZAfSmbWQpEbDt5ppwx5wBXbB6E=;
        b=iuZsNhHpou3lL0HuCPypm7lwGDE2atWIiiFWk52I7pHWUrWiSycjy6B9RbqqdAEdSP
         u9wu3PQ2AtSMuRch5yvQw7mbtXlVl2tC9q7rYZwQp4t/mrOEpHF4Ew+z5fW3GhjxtKeP
         2/K6kkTB0Mshh/f6D9QXTLVu11S5TilLwMZs7qPe76DCBBfpjUlqb6ieG0nsiZJ/Ybku
         3gsIapsSaCbRIagVR9+8r55yuNA83yLof5j3R4B0wiBZPTZG/z+AeQG0/dV2aCrRyrgy
         ARv+RKpdfmzdZDuNUun8LsgsFxOAMKHUqAuzTVLLgLRpgqneRHXtxzw8yWRvM/r92sjd
         IR9g==
X-Forwarded-Encrypted: i=1; AHgh+RqzsiIIzqCWElsutLnejaNDReCgM4rA9FNRwHGbnQYrQe54Vauitxu7TRHUNRgxcIRNAeHPj+TDL7lhySCLuA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnSpll8kxn/shvJyA2QAooFmkqQy/Lyf1+WkSpTDCpvjfUlqv/
	Fg9oVOx00+6T0DSEp+W8Yhbf94yV5CZC3fA7g9bkF6vlTqM2fD1yu6m0
X-Gm-Gg: AR+sD13/2IpTFoG5zI6uqB7NhLT7F16fywyOZ8QAZN0CANwCKxCP/x4CTq9kipi9AR6
	PnUqndP7Axs3UPSgHp0+xvteTPpObO8WsKPhe7pdX+G7JqcWjLjwxQ3Wtl/6YQ+GmV2pkpp/4I/
	Umjx29sYq5vTR+9HVDWpbfgm+/LTpkrEToF7ew8jfbKwbOsoYuMaLeuXC+xj+61EIbCO7aXR2ec
	V+MzGuTyws3tFfJXMzi9X1SxByc8Y0+sZ9eXZ3zCLbKRwEfzi3oKMVgeZcJCkiQOdcyu4UkGJ2I
	pmIHkkPTdw5Q4XxQys30d1nLZ80MYPyCGYo8PgHD39fSvQmU1ewc6KTaM3pisG01hdYGM7LutOQ
	cf7R7LnnK0VxqO6u3yAQ6R4qnULqN4dKW83srsGXDsdyIfWP5v/oJ+pqPKlKgMNPOpfAkieYizR
	SsMwVdSQFi/DfTRAGV6X6aP9EK5sYZyA5MXBzkhB0OTs2rlS/vyRSsOFuDzOvf
X-Received: by 2002:a17:903:3bcf:b0:2ce:ced3:490e with SMTP id d9443c01a7336-2d035e6e9a6mr11975465ad.39.1785391579309;
        Wed, 29 Jul 2026 23:06:19 -0700 (PDT)
Received: from kdev.. ([108.180.130.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a46774sm20780785ad.27.2026.07.29.23.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 23:06:18 -0700 (PDT)
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Babanpreet Singh <bbnpreetsingh@gmail.com>
Subject: [PATCH 1/2] watchdog: wdrtas: Fix kernel-doc parameter name for wdrtas_reboot()
Date: Thu, 30 Jul 2026 06:06:16 +0000
Message-ID: <20260730060617.7-2-bbnpreetsingh@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260730060617.7-1-bbnpreetsingh@gmail.com>
References: <20260730060617.7-1-bbnpreetsingh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scripts/kernel-doc -none reports:

  Warning: drivers/watchdog/wdrtas.c:460 function parameter 'this' not
  described in 'wdrtas_reboot'
  Warning: drivers/watchdog/wdrtas.c:460 Excess function parameter 'nb'
  description in 'wdrtas_reboot'

wdrtas_reboot() names its notifier block argument 'this', but the
kernel-doc comment documents a parameter named 'nb'.

Update the kernel-doc comment to document the 'this' parameter.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
---
 drivers/watchdog/wdrtas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/wdrtas.c b/drivers/watchdog/wdrtas.c
index d4fe0bc822116..6c25171de224e 100644
--- a/drivers/watchdog/wdrtas.c
+++ b/drivers/watchdog/wdrtas.c
@@ -448,7 +448,7 @@ static int wdrtas_temp_close(struct inode *inode, struct file *file)
 
 /**
  * wdrtas_reboot - reboot notifier function
- * @nb: notifier block structure
+ * @this: notifier block structure
  * @code: reboot code
  * @ptr: unused
  *
-- 
2.43.0

