Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4ACB41C71
	for <linux-watchdog@vger.kernel.org>; Sun, 24 May 2026 06:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779602663; cv=pass; b=iAuR2a1f6rxC8sl2CbZE4hsfr7UnxO6HOMOKaKTQHj46ZmMIQUFaopYNJoABY9PVOBcPfMbp7yAmVSHuUHz2UKssj4yp50iGSXPrJNoUc6CCSvurBDO0ZOHIPGgORdpQi+o0G0qNK82nNQ2USXGeV6Ojy+ee93uZuLhk08VApdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779602663; c=relaxed/simple;
	bh=hUWIU2DU079TWJeMOqXMVpVt/r1gDnnT/HgdrbsSoNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FX41eoaqCiwr/FTczmar57d52M4F1n2iUGUzWn+EkxznxEYwCWpDRTeeKVI5aghSU+jGNmRqzq2/UrK0sUcItQdYMQlBcgUAmkvEOp6gjZCsR/9TTKwCMJjk9o/EQ4s41hNPnCQc/nRic06M25cXP1O+QvGTY8PpHKh6ByuEsHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o9J5sMrp; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o9J5sMrp"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2be75f658f3so38311975ad.1
        for <linux-watchdog@vger.kernel.org>; Sat, 23 May 2026 23:04:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779602662; cv=none;
        d=google.com; s=arc-20240605;
        b=DsfMlvw1DWGjaa7pVBRSQurm+dTH/8m3L4stSDHmqImTnt8JFGGVH1zdnoaWa4W+g4
         NzsYSI+Yx3/ATgpXbXKsVjWlHRjpSEWXGwXUnoGZ3SUjt1AODH3vesMk5VCKe9WlqN0s
         h9EquFMMLvYgH8YizC1K8xgPTnGchAmtCyGjfmq+bFShGTolNjavr8RGcEncfgbKKZ47
         z/8fpAxhbSeS1Yjd5ucU+hdmg4XLANs2o54l5rv0KGPlM6MXKsYDvp2bIRg4BLbF7Ye/
         paJWFjCRium5pK1011cnxR7dpmn8WqfPe/dLFI24lYzA5ytbT5wRLX5Wcx1rWzJA2r+J
         e9wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hUWIU2DU079TWJeMOqXMVpVt/r1gDnnT/HgdrbsSoNg=;
        fh=uDcgQSDfORdl9QqI6fdbQfWs+xZOeFJ92Kga3iqMSaQ=;
        b=YNBQo4m7QH9SHD4qTADOajhAG7e8iIzG2/Oe8rT7+HzBfx8o05ffrTKHOu/jSgNxq6
         LjhAqY3l8EHo4h4AJKgWdRdnxjEGeC0ISOPbr5gIG+5swiNu8KDL2fD8nqCgy3vG3eCY
         b4D1WbkmVXDQtYoVva2fYJYmc+fCUWnKNw72FaDrlD6IZm5+Er28LLqv+ady0QsiYoKJ
         jLChcLWDFHBYIbif69sRH0AGzNODZo2dIa4c+LhjRB2Z6aZDeQ0e9RQ7bsqQXapeFr17
         kY5U8wmU55GxN2Ae1EVwtsLnRBhVsu1RoEKwy9Q5am5BdL2dkqNBflCV1fYJ/E31WV4S
         JxCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779602662; x=1780207462; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hUWIU2DU079TWJeMOqXMVpVt/r1gDnnT/HgdrbsSoNg=;
        b=o9J5sMrpoNsERjA5TPSHe14XPNu4HKjRh6Cuc7oj7wHiUrFOjQ3g2tyx0lwVMh61PS
         Eh/a7GErZ2x5KzLc7uHzkwWBvvABLM4wCL0IEG9Hver1TLdGs3AhyDqW3RaRdcPIY4/C
         yUeKH0LpJig33qUPGK90sGtQistx6JymZ+gZWtX43chFPUiGMuTf9IxePvc2JJSrDjJR
         NQLVMiKsIM6eQT4s4QW3F7b2VJTwbB0TxpRho0Acg4xOVOkAoPIisuRJNbCmggQpK07C
         V4+j1EJwJ16DLBjsENEJ+Q0wqey3g0gu863hkw/5s/dkZAElE4oVb6Hkv4/VBsud5mal
         oQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779602662; x=1780207462;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUWIU2DU079TWJeMOqXMVpVt/r1gDnnT/HgdrbsSoNg=;
        b=Wv6YStMy6nYLKthUN6yG6DMSOPu9K1BAIhb52qKhTgheikVkt48JNAXxwJFOf3SGCR
         28zTCQkrr3GRDEWDQkmLJ6ggwirZMVTPRuvbv53wn53bIM7VtFWFHjD8nPMOL6Wxxa6F
         cGgXZQ0FnSN4QeMfZkVsamEzMHkeZP72nNiTPul9JLDT5nAB+fMGLIqJNmi0btLmUskT
         Rf/LtrCgm77r4Vk+OmZHSNF9NyM9EjvjyEWxdn0VHBd6XYH0YBz0YB//g56SxKNIhEVl
         Jsz0MTFTDIPAn7c6R353fyHr91M28zpx/PFHA9CfTGEelBHjBF9IVHy/Dots9ccUNKh+
         D8cQ==
X-Forwarded-Encrypted: i=1; AFNElJ8I76+Nv4ebHWpu8xWt85tNa1ORJdDUl2W15LiMfRuTL3p2K1w2yA5Vgb5jjFW7vUvcHdNV+3z8iODGM8SO9A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDp1f0JbEQ6d9Z6n4SrHPRUUN0MZ8xLX/YGwOqitjHqEMwkGjK
	Nqsqhh72CVxgdbwwiJ8uh3IIuq5yPvnHdk0IfUNqueeomZXqZvBaSWNwwEjD3CS6+HFEXn3XdMp
	TsRiAIaAC1xggmjJNMt68TFugCqdfq34=
X-Gm-Gg: Acq92OFNMuLfT4HK4Anow+QcT4hz4f87kcTWOCFSLQ+nRuNXdZlN5KikiuWiEy8HJ4c
	7+ZM8nGp9W2RM/mzuHkeUea58+HNI/uHhsvX7fGTpPB5rIhsVxo1GjsGzcclpSzriw4ES4+5YbJ
	rsSNR4xYHejlUGppLCtzNDLHyAI9k+b7fQ2aSInCOhefoO130WYt3dxrG9jU46YMlGdu9Qkf+Gw
	hItKXP7lLTfa+TcRqX2K/vORliazeX+I2hbY++qMBsmrhWTGIT5a14GObsqUlZx0mpDND5GlsdC
	YN1b9W6Itt9LDcVMzgkKcHPXxDdaJnE35B1LzekuDixHOkvQnFpIdhccTCFrqdrNi7Nqr0Ly6BY
	t6Tol6MwaQgpT/tgHXTKn
X-Received: by 2002:a17:903:2348:b0:2bd:a403:1d82 with SMTP id
 d9443c01a7336-2beb074fa6amr109163535ad.21.1779602661905; Sat, 23 May 2026
 23:04:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223-sprd_wdt-v1-1-2e71f9a76ecb@gmail.com> <5ec9bd47-4c58-485a-bc20-1a74cbdef40b@linux.alibaba.com>
In-Reply-To: <5ec9bd47-4c58-485a-bc20-1a74cbdef40b@linux.alibaba.com>
From: Felix Gu <ustc.gu@gmail.com>
Date: Sun, 24 May 2026 14:04:10 +0800
X-Gm-Features: AVHnY4IJL0prq4kaGXPJNUele6zmJit7gZ6ZlIvdN0zfPx4yuv21kM3WMZ6Pdsc
Message-ID: <CAN4SLj09_mAPxR+k-qnOc6LWwh3je4-DJ9-BrfGR_FoEefjfVg@mail.gmail.com>
Subject: Re: [PATCH] watchdog: sprd_wdt: Remove redundant sprd_wdt_disable()
 on register failure
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Orson Zhai <orsonzhai@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Guenter,
Gentle ping.
Is it good to merge?

Best Felix
