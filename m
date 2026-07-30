Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2643644C6
	for <linux-watchdog@vger.kernel.org>; Thu, 30 Jul 2026 06:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785391582; cv=none; b=YFVycepyVewSwn4rHiwfdlThvTl42FBDfVQnZuS8tqHraPI+uhVVE83BIzvOLkXscWO4UM5xkO6QOLkf9PtTEr5SNdd9HzmlxRid6vg4EEm4X+7IfDqKDiqdCnkypxUUxSgM8YvHfjsKB6Zsk/Tu9lYc1VSVWaBOZ1o35wdNlvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785391582; c=relaxed/simple;
	bh=Low4IivJn86jnGI3LLU/Ae2Spn1lU607J8byZ/ZoSKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jVQK0atb6ky6/L3j7UNvnA+l3Y3OAH+0cGwLTvkHLMkTru20rQkFe1eSwrkI9AYyMc5tJdXhEM38kIqXQIM6QmtgZAfRnkIrBW3lIJmUZf/vV88HxhFd9on0+XAGwTsAjvcKU8eIzSgmgZKr+MBPFn3rpZoHiFoADlZk4m/LXxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IeR6CqYW; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeR6CqYW"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cab973140bso24183725ad.3
        for <linux-watchdog@vger.kernel.org>; Wed, 29 Jul 2026 23:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785391580; x=1785996380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oc22gTId6HvmzrfanPJzdlwN1Vujg0CkMxmiMkWQDoI=;
        b=IeR6CqYWX2ZyTY6P085zYF4qLDJ08QLcS3/BdfHQhJbcWdpSBm8yExE27211PeUH0a
         +QfNvOymYqjDALPlMbhUBaevpM81P0cQ1n21fISZHc7zTTGTatYbUc231IgBPoNUlgJH
         x4zsB5RDrD0E30oIUaNCTnlgRfJ09c1Rzmx3rlZOI71hUBGp3cxay8rOMhAm1dvunMKW
         lqYaSTzniHLdR4WsbrzpGJrwlQAB+/8+uYs1D44nVQU+r2UGSydSOKogf8zicFNTtyWC
         fiu6ziixC8AyXg5sDBipdUqrwVHfgX5xS3Zh5O3Yf8BkoGH4FqJ0NOyAirtZL3KblQAm
         0vWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785391580; x=1785996380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oc22gTId6HvmzrfanPJzdlwN1Vujg0CkMxmiMkWQDoI=;
        b=lMhGebnF7JmQUe1UpXIFrHYZD/1P/ZoeDs/3jvu6HxvK1rMyz1CR06l9dNP36ASAWg
         ji+DO28jxf+2+0bLfY+kjm/DXQ3FniOhIGmw1WehT5+ZR5l6YuqDxymynZwoWvasXAuc
         UtIYxx5a7qR6O70uPpk2QITrr5WBg/X5CnR9p5yM5PdrWepessCrnga/Hwt9FLdVKkrS
         PW3HbWYS2Bq5aujA5lxAELHxalipXiWpV/97vrg95ZKM7qGujQQ/hrEDLPMGsnA3I9x5
         X9QCgwa+03TpBOONrw9BYWJeRhA22eXxcXCXSaKa8zZyjw2Xd60lod2CKSdKmAjVWWhv
         ZiVA==
X-Forwarded-Encrypted: i=1; AHgh+RpB19TbaYMVK5NtAx6Me6VnfdWjIKEFkGh0vwVIEtGgMmHmYfvwsjrnyKd1q0s5GpbIzfRyU4Zk6vV/DabIgA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyN47EVwM1M0gVshwfA/4fpgRJ+jGqCkk8024Bk8iqUxXe9XBt
	qMamL5mpewKDYES8Q5c5SklXY6D35FyWXTIgYYza5YqdnZKtsWAPZkh0
X-Gm-Gg: AR+sD12VHPgzOFeoXDwlZpJr/uR/ODZ6KPd2ugZeGRnBuWd/9ZNtmsBSFLTUV3Pxbe9
	zaTdtH1s+B+J0vKW8NNPrTvNtRn4JhFumhLarYvYogk91m4Wx6BPuojHzPmzRO2joH9Svr1llzK
	U74VrBDnBa2kOxAO1KwPuU22inyUCRa6jaatr/5VMCeRqXXdUIg/hWngSJYN50n7h88yRL/iUdu
	z6AKLrdmeGWj6xTZSAI9ncI1iCuwbjeaE5TgRmwbAR+vFXyE4831dg865K4G7xdbR+Ie1E4x6Hl
	kLcVsM41+Ho34Bl4Dgp1XPZyNmXyjLDqb9PD2BH7eqXT4vd6iM2RhDfSee1q1KQFS0vEnKnN3aJ
	/890HtyAuTprcVO1bxVBC0DPJ+ISNLQ711EwaS7gEeKT0XeugLyehcMTFARstRhY2s9OQ4kebtr
	Qq7/gsdufqm+fGHY/noQMD6lyUXYmTxZTwt1URlM2l17/NZkzSM7WeTJBgVsb8OiJ60DzkqSE=
X-Received: by 2002:a17:902:c40d:b0:2ca:d7a0:1312 with SMTP id d9443c01a7336-2d035c864a4mr16689545ad.25.1785391580093;
        Wed, 29 Jul 2026 23:06:20 -0700 (PDT)
Received: from kdev.. ([108.180.130.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a46774sm20780785ad.27.2026.07.29.23.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 23:06:19 -0700 (PDT)
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
Subject: [PATCH 2/2] watchdog: booke_wdt: Document unused parameter of __booke_wdt_disable()
Date: Thu, 30 Jul 2026 06:06:17 +0000
Message-ID: <20260730060617.7-3-bbnpreetsingh@gmail.com>
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

  Warning: drivers/watchdog/booke_wdt.c:158 function parameter 'data'
  not described in '__booke_wdt_disable'

__booke_wdt_disable() is invoked through on_each_cpu(), so it takes a
void * argument that it does not use. Its kernel-doc comment does not
describe the parameter at all.

Document it as unused.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
---
 drivers/watchdog/booke_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/booke_wdt.c b/drivers/watchdog/booke_wdt.c
index 932a03f4436a3..1b1fb389b89ba 100644
--- a/drivers/watchdog/booke_wdt.c
+++ b/drivers/watchdog/booke_wdt.c
@@ -149,6 +149,7 @@ static void __booke_wdt_enable(void *data)
 
 /**
  * __booke_wdt_disable - disable the watchdog on the given CPU
+ * @data: unused
  *
  * This function is called on each CPU.  It disables the watchdog on that CPU.
  *
-- 
2.43.0

