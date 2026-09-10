Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB34345ED8
	for <linux-watchdog@vger.kernel.org>; Thu, 10 Sep 2026 01:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789002854; cv=none; b=pmkc79M/VqAvmtj2UcV4EqKJufPuANJ5G68Tp0nwh71ufYdx3xnO6zK8q6UwmBAKbGR4jH5zogwKJfRLeEgAKwdf4+VMQN1Wy+W+Q4kdezrhFGEvlI3zYiyCMtxZ5QtaIkgrbCUxsuaZRru2aDxiN1IyS7qi0ZmFU/yKtjSgMzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789002854; c=relaxed/simple;
	bh=rLLf3S99IRsirnjuO8ESHgbij3XAtfezDUthT0uJ3bA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a+b29FKEvF/8Opse37MOZLa2UxIH13b9rSzfun5HnN1tlZPqKxBY95KtP+dWS0kQwrhsEo7PihkAN/QrtXNfB92Ftu4Z7gEfD1LnuuGwCA1IwFJHWqBYBSOpTcuFPl7Q2Fb7lAOCnsh1YKftFGj3r6lbXI0QRlBHZnwrxaFmrqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgSQ7XTs; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgSQ7XTs"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cebad4acso1403953a12.3
        for <linux-watchdog@vger.kernel.org>; Wed, 09 Sep 2026 18:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789002848; x=1789607648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J/8WXv6niyWS/wDmzDpJhEOm84AGncNzXJmc949SqnY=;
        b=kgSQ7XTssdC/w2V1BMfNXbHS7u+1Pb7ezJzYyXQqXchUXnuQjmSmo+/Gm3v+LGXETh
         DPNf/SeduOK4FO7qE2+Q6xApQviDHx80oymKInD633uW+iY7dbUXq9muniClNg3R5vDW
         x96/JDjwnwOTzzvdByXQJdP43jcaEWNjjfGvkghripLB4/ffyNNFLcX23AeYZvvRExud
         I+XyLrt9NdVhrie2A4iq2W7/EDN3l09BnKwLMCQmUfIzrrYiud8B7OATlJPHpl+Cfgn6
         dPqUUlmixisDpXb31DXnks6KU7dSFz4jKnWmAjEovANaYGzphLTIZDVX1R9pyknbPj/P
         0mBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789002848; x=1789607648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J/8WXv6niyWS/wDmzDpJhEOm84AGncNzXJmc949SqnY=;
        b=jtc+fAdOFA7k96KBPKHj8TK3Suwd6OUaSCUUNctwUGFPQXZn54sRZJBKX4Z9kaiL5L
         qlfNUjjNFMah+CERcxXBB+n/9y6ARk2+Hd/jz52JEEQ8u005tJvAE8QVTiVRc47e45ve
         XXZvEuSNfD1Ymw8ZUPNuMTFgjRw7seQ/I8eX3gozct/VygDISeCEDRAo6gcmObM++5MX
         D0yGfVidrWY8l5DeN9x5a2GDCgZgVP8vJQ2SoDeB+3eFJbmWchpDQOWZ5uQPjv3q/Sd9
         XreDGTWrtW/tK9oFDvuUyZsFJzjN1TYlexucfEzVfMEEwJnux9DDigQvM1x6lmhW9DrX
         vNYQ==
X-Gm-Message-State: AFuF++kgmk0ye2NOlt851huj110JtjL2StbdIFmZmF8W0PqdWkJ6FZad
	ItbrpmkFZD9r6emE5zdRwC5fMRvPdWy9AKM1yR3rRUIss2fIS1eHgu/nSyf+JQ==
X-Gm-Gg: AYBFou1N/zvs4bFy9bkpT1qnp7KjsQSGUWCPDTk2cMP6gqyLXpIvDBrBwnO8U39PU7X
	LBv8/unfBS6y2ZdTWaUdYpP1p+uk+JVf1s14uaqhRo9DW66jmZdRdigUzsDdRsgLG1/hkJcqZtf
	+z8HVbKf/sLVq0yrQ73JqLWBrWV1Pz5Hx25RvSduovTgzSwZ0FVFJqE1XuBn46ThVhPxhoXn3Ui
	Vo0c57PgzzVuZht6+Hx9J3H+hBbFVzME1DpO6OPSkvMJhZrczp21acz/9+2oeY+0mXs9x/krgKA
	soDKiwO7EBR03SkzTuTkG+Nnm0aA8ndiy+gruwfDBVyPKZS2kot6oYsvffnzt+e2rhfY0VPM8hB
	ROdD5qfY10T7eDH0XTtbPFXZMGMD/aRnSbIFioCYLoMSuIfwnpqgpViliHGYdaSqdCawPR7vyhU
	3T9FCPBEFX4k2Xtt6ceCWnspiwfThYLlch2uryiyqPD8/RiMcjYHT1cnDtonHL2MsgIWYljv6Zy
	ep48DHjCY8O
X-Received: by 2002:a17:90b:5705:b0:398:9be8:ea66 with SMTP id 98e67ed59e1d1-39bac3f1dc2mr13886765a91.19.1789002848176;
        Wed, 09 Sep 2026 18:14:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3397d6d1becsm10037195eec.22.2026.09.09.18.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 18:14:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] watchdog fixes for v7.3-rc3
Date: Wed,  9 Sep 2026 18:14:06 -0700
Message-ID: <20260910011406.951178-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull watchdog fixes for Linux v7.3-rc3 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git watchdog-for-v7.3-rc3

Thanks,
Guenter
------

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/watchdog-for-v7.3-rc3

for you to fetch changes up to 01504d14e47b34779911250dd308a03f6ef681c2:

  watchdog: msc313e: Sync timeout value if WDT was running at boot (2026-09-09 14:18:25 -0700)

----------------------------------------------------------------
watchdog subsystem fixes for v7.3-rc3

* core: Do not start hrtimer when pretimeout is zero

* msc313e: Various fixes for issues reported by Sashiko

* MAINTAINERS: Update URI for watchdog tree

* sunxi_wdt: preserve boot-enabled watchdog

----------------------------------------------------------------
Antonio Borneo (1):
      MAINTAINERS: Update URI for watchdog tree

David Arcari (1):
      watchdog: fix hrtimer start when pretimeout is zero

James Hilliard (1):
      watchdog: sunxi_wdt: preserve boot-enabled watchdog

Tzung-Bi Shih (7):
      watchdog: msc313e: Fix NULL pointer dereference in PM callbacks
      watchdog: msc313e: Avoid division by zero
      watchdog: msc313e: Fix clock leak and spurious timer in settimeout()
      watchdog: msc313e: Enable clock before accessing hardware registers
      watchdog: msc313e: Fix spurious reset on suspend
      watchdog: msc313e: Fix undefined behavior
      watchdog: msc313e: Sync timeout value if WDT was running at boot

 MAINTAINERS                                    |  2 +-
 drivers/watchdog/msc313e_wdt.c                 | 74 +++++++++++++++++++++-----
 drivers/watchdog/sunxi_wdt.c                   | 45 +++++++++++++++-
 drivers/watchdog/watchdog_hrtimer_pretimeout.c |  1 +
 4 files changed, 106 insertions(+), 16 deletions(-)
