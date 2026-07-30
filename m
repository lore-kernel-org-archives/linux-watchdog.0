Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43230328267
	for <linux-watchdog@vger.kernel.org>; Thu, 30 Jul 2026 06:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785391581; cv=none; b=LPSubbT55TlcIITv9h8gRs0Ss0io5dU9qb8Cp5BmEObVosqUshTj+wgHSfsmdkz08q+vhL5FBnBb7v3cLGbdg+z565TyEU0PZ0BpiIdjcUSL1ez8aQDKo5ib+73QfgSNvE4z6nwK/73OvXZTASDgjzr+62cDPCmyp2o0tKNK3fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785391581; c=relaxed/simple;
	bh=wOjTrh7Elcn+anl77bQwwRQJKWGCYAsse5T5yehwaVY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QrHwkEpmcAVkd2Ygc0wUu3XBbrUodTFTtXf39D4YDwJrOGX4GqPF8K6DSpKfPvlKabfPYp3FVvGLIYSTi4ftcCpd5Ab260IB8BvEDS8QrQp00YX9Pgajbob+m79b/6RkGG1FeC+ZVn2RzMqC2ikKZXJtjpi+xYJ/l/VabaYx2oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhisQqP3; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhisQqP3"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2caea3f742bso21577685ad.0
        for <linux-watchdog@vger.kernel.org>; Wed, 29 Jul 2026 23:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785391578; x=1785996378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=N2BsO/SXniFlM6SCUrq26UllYv+rXm0p9PUXKwY1gig=;
        b=mhisQqP3FO+hzBf/FzOzfBzXsdKIWVqum7QMWkCKp8j0tkvx4/ZU+usUaeZTIpj8gD
         P6cEQ6hvJlvXtEDGL8OK7TkZSQEFtXMm98dyj+6KKOSQjxs9hxsywm1xqk1nGIkc8Rjm
         P8PDZgEQfX52q02wadpUuWdnTvAipYL+/YezDTkA8P+KOhBXcYXRvPpR/QTWPg8p68+o
         dyAzwolyBP7Azm/brdfIroyHDofESt6KXCYa1WdbzoqC9fUqj7iJYSPyb9mDSH3C+yyc
         hsM7DsIS01qb2vt3Fb83cYmcaJ65SLXNSqeOCnlMhk/4vHdPx90/N/7xJWmzGrgHmTMU
         lR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785391578; x=1785996378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N2BsO/SXniFlM6SCUrq26UllYv+rXm0p9PUXKwY1gig=;
        b=iIGgNLONNflyaeqkBNOVVnfiPk6qVJ/jOqC7M57t8v8VAofPogvgNVvHnRA3jKR7Zc
         Ksc3m7jG2K328rzjdsKnmWOpxzlESQkis28sez/QiwOhzNEHLhDEteNZvOECt0gYTXSc
         sLep910E97+i6NVSDOprOj1iy5Pkz26ZzKrzjvlgrysPmu5/B4r8ScyfH8SXcRl49fGp
         97Ve+LUyeByiexKZr3vtXdNttVBFhB05szWD1mnOJQSWlF6I+iE9g5Is8DIAvNDuco8h
         86qs0skB5ahRgnv/BmXEbTyOKF4wUiiR0TxoRZcYuEfRrz/Kw5A1ylD3Hwc+UFGxj1UW
         qtKA==
X-Forwarded-Encrypted: i=1; AHgh+Ro7amTr0uAVxc/iCEobz1p7xKZGS1gZTx3oyz42gWqw8NHdIOIofm9pB/MgJixcnmOBtoMfKg8a8LwQshTifw==@vger.kernel.org
X-Gm-Message-State: AOJu0YydoQuag9qISiDiwafjdOU9eUHR7pCsxQgdqh5EvzHdtXIRKcXk
	ylk/FmB2dHeDDkqHYJel50tCJnF6KhSQo95ooSo3zVwfHrN3qi4RiJCo
X-Gm-Gg: AR+sD11W4jDu4v4L6JOpvvcisD524v6x+Gur9uEMn6e+hQmCOIhX09wLXGwTjKdI6Di
	Vc3JtOw8AwspRC6AhBK2BCqYiI3zqDYSUTGbh0FFaj2EaVIDWsW6a8EKptqpO/zsCbxGbffdHdc
	6RuJwHKD9RpimBDZqlDnJnKGhh2OMmzHiOHAxaRZKQ8A9PZ76X6E331E2Yyt0tDeF0ocm0hxEc+
	AyL6w3FIun4BmK28UdGEC/zk/3rFv5Ahb+jhFobyzlAxTFBRWbfjJCpagFOPzzRkMhsuLqxhzS1
	rHrcij3eqNthOVSWB2FnlALGhkc/NitREPA8y0Dv1v1Z0+hO8aWhkOL9uaeYN4vDKE6W8UoTOfk
	l/Xw+yCPjbmW9CkWZEYRGh5frgn/kX1TTFABNPahJ965Ja+YfxgaNBPWeNI0VaBVEgGRXhjPVYb
	SuZU6n6BPWUIN4o4FC0w+Whjs2o7l/AgeUnM4J52LxUTmIyjby/gIrlBy6zKWB
X-Received: by 2002:a17:902:e847:b0:2ca:ed41:d33d with SMTP id d9443c01a7336-2d035e4b84bmr13293455ad.45.1785391578502;
        Wed, 29 Jul 2026 23:06:18 -0700 (PDT)
Received: from kdev.. ([108.180.130.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a46774sm20780785ad.27.2026.07.29.23.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 23:06:17 -0700 (PDT)
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
Subject: [PATCH 0/2] watchdog: Fix two kernel-doc parameter warnings
Date: Thu, 30 Jul 2026 06:06:15 +0000
Message-ID: <20260730060617.7-1-bbnpreetsingh@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two independent kernel-doc parameter fixes in drivers/watchdog, found by
scripts/kernel-doc -none. Both warnings are in .c files, so they appear in
a W=1 build, and both files are clean afterwards.

Patch 1 fixes a name mismatch: wdrtas_reboot() names its notifier block
argument 'this' while the doc block says '@nb'. Patch 2 adds the missing
description for the argument __booke_wdt_disable() receives from
on_each_cpu() and ignores.

They touch different drivers and are not a logical unit, so they are split
rather than squashed; either can be dropped without affecting the other.

One thing I would rather state than have assumed: both drivers are
PowerPC-only and I have no PowerPC toolchain here, so neither file was
compiled. The whole series is three lines and every one of them is inside
a /** */ block, so there is no code change to compile. Checked with
scripts/kernel-doc -none (3 warnings across these two files before, 0
after) and checkpatch --strict.

Babanpreet Singh (2):
  watchdog: wdrtas: Fix kernel-doc parameter name for wdrtas_reboot()
  watchdog: booke_wdt: Document unused parameter of
    __booke_wdt_disable()

 drivers/watchdog/booke_wdt.c | 1 +
 drivers/watchdog/wdrtas.c    | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.43.0

