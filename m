Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794314358;
	b=W47dSe/Di6ipu0QpyvgfiZulwgHn12N+3n0uRBhTDNzCOQivO1kTE5dKRFjh1OBYjSlp
	 sd7seMUZqI8+Fcs9oOBvmHS7XB/lh7bQgFL3oWABkr+SbKxwsPkU+XNibYgTxXNhl4Eb7
	 x60Ojia+xqZvdFlS93+UVkBcMOJToOhRjxwC5GrA3mdRe7yPOpuRBVBNROZKQk1jfnn5o
	 lZaorHWn/zSUX5J3Ub/q68P5KmJcNn9F6oY4Dhj6iWAG2KD4EDrp784DW5lPi1bgT8Zra
	 vorkJ54ogID92h5JysGuWcPNm/mcE6xtIlrUQyMuwAc4GxMD1l2jGB6F+6Uwd8x/Wcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794314358;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=OZA5SPU2mRDufyjwAtelDUROJpCDjs2VMU42+tn57Ec=;
	b=wnPMOTlVkoAzw/AcAfmEaTxroVRkv7m+OjnTuxKYYYY6sN3pQVnJEhkXVB2mFK/1KO2s
	 MmKASaKmn2QHtxKkcfRIv4fGBu1ZVxfIydB/RiQ3PjCzMW2Qp98xjdrEGHknPmq/gn8QT
	 zROVfUtDAIvJs4AH3euUQfIjA4HrrVxUrIueY0lRtXUmqTo5sx3a+oAKSriUOFJI9uCvC
	 ptga4JhlYYHhyfiEi44MuWb1quO6KFvGiPX9rucXRN8IqDCz9k0fBMND0G4PMG/+QDruo
	 YxniPeeG/15xowcqCJOlOUmFi+9J0WefbJHqn5E/jSyhm4wgF9HUFWzD5+Z+LgVYSQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wz8+8w+j;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A95606A325
	for <linux-watchdog@vger.kernel.org>; Tue, 10 Nov 2026 12:39:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10A95606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wz8+8w+j
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4b7252a32c8so20914885e9.0
        for <linux-watchdog@vger.kernel.org>; Tue, 10 Nov 2026 04:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794314356; x=1794919156; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OZA5SPU2mRDufyjwAtelDUROJpCDjs2VMU42+tn57Ec=;
        b=Wz8+8w+jVziIDfWNptSTmLnFeI93h0avw0Xiq7bpV40LNJ18YpCROGSGMGCIUQcE/c
         CBymg2LEgIOQ5/0hNk9V/WgjGnzjFnfBX5e+ZVAdJit6StFgI+DhR/+5Fc4SH2WEw+MQ
         YRcLKRxwa6citZXQZtQ9j2d8GDdziuibjASNrPOGyeWtan8aeTbp4lgTDegGyxLojmqe
         gAk5QyD0Dx0lZwXLu112ruyhSPO65s8W0B3gNZgc+7DpMWNUnvQEe48JE+s6+P27E8LV
         5VJXXrWtFeLIHio4EH7SHZbadXfxLVjxZqNrdQduM58c/qKLRrRuzZNJMZF5+d1gmpYX
         bucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794314356; x=1794919156;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OZA5SPU2mRDufyjwAtelDUROJpCDjs2VMU42+tn57Ec=;
        b=XbfSanXyY2aEveKAWLchSjGD72R9kElanNSSkQH4lJOurr5q72SRqLjhJHSXCxv6au
         uHGQ3vvu3/3OI2UnsuiUnGAmg1fDbCjpnHF2YUfcispFouOtdZFEPusVaF/61Mw+QNQ2
         jgE8Sg9QCvA6k7tQ+Sa2p9qQVLY7EJjQZDKc5MQcLXM1Zb6fgwbBWUn0Yf23otpZsBco
         0yAdGWE/aDvkKr41SjMxm3p5O1O598JDa5BapgL7ks3KDCeRllUOeIwEIN7T0SXmTtdi
         2RDWqKmVfMhwV5f17dP0eDnUtvF5BaIXb5C2ul761SXOrqsWIEcN16MCyu3FMVDvuTSF
         0u+A==
X-Forwarded-Encrypted: i=1; AL+hErE/fZ2/x0BbwHyfcUni68JXeN/rfGuv1U4WHeSDH3A5hyOZZLHAVoxHcmt/USCFoqrHLRGd+nZBgq2yUIcc/A==@vger.kernel.org
X-Gm-Message-State: APuU4Z/wYIFVhEiSFkU/i/FqVuOOeVT+yJCbR3AoGK9Hn0KsNFdaeYdw
	uVTigAVly2UuDLw1Ztb01pVXITGoLBoqQJf+cuAuQgLJAHswSClLuYv4
X-Gm-Gg: AYBFou27FoIvH/uNrYKTB/zML1s7BqHGok0YG6y0kG2Yc2bANQ3HyRAcqz0HE4T/NMf
	VOUjSBJciHjreTCcbM8UtPRqmnQQsGEPSresfsMGwpp1K3/VRVtYiw5lP4/4+7xFKNMun+xDskY
	IyV0uVlViKLpxh0epYd9lCPLf+MAzlBrnd7eAj6l46c2y++T/nfMoGB6eNGr5C2ZztwImDpUzF/
	BCSqgUv4Zj/5IFyZgmjM+Byj4B0q4+2I/rkbG3m+nhBW9n1TiI1yb3AHUNzgIzq7qrdL4HQtBtU
	UwD1RuQZxLdnVyowKqiQlHoxYr69KwQ+4TXdB8CJP7BJ/Fkdbl3qidAqidhT1drVi+a7l/yMsx5
	8zI7XRLJ8acl1UJGgk6bU6dnQEsSLDPpgIUAIZHAZV3neyXk2flb1UUmcMVCFJTYVBabKLWOvC3
	Jgf4YLRAFajEewu6hbnKwapPYkPwSR5VlhpF+QATc2Q1WpuVe0d05iqLtNKweDrmFz6z+bOmxLq
	RqcaRMdUTNRMYqzCS19pCFr/FdJPIEmmGcm7P/bNoAyLlTT7O0IVULz2Qi/NCp+cSsuA6QSYyQu
	ZejPBJwpMz6X0R7jXhlrNvoIf0eKibtuyy/yfZOX
X-Received: by 2002:a05:600c:4f48:b0:4a4:4d57:8462 with SMTP id 5b1f17b1804b1-4ba0234bc33mr47799765e9.24.1794314356334;
        Tue, 10 Nov 2026 04:39:16 -0800 (PST)
Received: from [192.168.0.15] ([2a02:a312:c59b:a180:251a:f25f:80fa:af1d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498363e0019sm5050033f8f.38.2026.11.10.04.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 04:39:15 -0800 (PST)
From: Artur Kowalski <arturkow2000@gmail.com>
Subject: [PATCH 0/6] watchdog: tegra_wdt: Add Tegra20 support
Date: Tue, 10 Nov 2026 13:39:05 +0100
Message-Id: <20261110-t20-for-upstream-v1-0-5923449951fe@gmail.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yXMQQrCMBAF0KsMf92BJGgbcxVx0capjmBbJqkIp
 XcXdfk2b0MRUylItMHkpUXnCYl8Q8j3froJ6xWJEFxovXeRa3A8zsbrUqpJ/+TDqRty1x59jBk
 NYTEZ9f0rz5e/yzo8JNfvg33/AB/jS+l0AAAA
X-Change-ID: 20261108-t20-for-upstream-497bc765188c
To: Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org, 
 clamor95@gmail.com, Artur Kowalski <arturkow2000@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4066;
 i=arturkow2000@gmail.com; s=default; h=from:subject:message-id;
 bh=T2iP2KMR8ZGTOcw9sKv5YtssoUQpg/rlCJarXcwIR1M=;
 b=owGbwMvMwCVmYeTc/TaVxZzxtFoSQ9ZngUKDBQlPouvfurE4vZo4c4ayHdOLveyN34S/hf1b5
 vvjG9/GjlIWBjEuBlkxRRazh0JfeOZ5vd/wcmsnzBxWJpAhDFycAjCRCbMY/lkt7jy9ep5b//s5
 13bo+Ty3sFBZl7xDW27x1P7A/4fyguUYGQ5JnmK9k3Owbsa6YpU8v4rilYZJK78fMlrlnDOzcrl
 3ERMA
X-Developer-Key: i=arturkow2000@gmail.com; a=openpgp;
 fpr=F60710C8D69E03A01A2801CD87A47D20C2709637

The motivation is to improve recovery from kernel hangs which have been
steadily driving me to the doorsteps of psych ward for a few months.
Those events are rare, some happen at boot, others while trying to use
tablet for something real like reading PDFs, browsing web (to the extent
possible without working GPU accel), or just using it as thin client for
another device.

As all my attempts to hunt down even slightest hints of what went down
have fallen fouly (device just refuses hang with UART connected),
therefore this patch series is born in the hope it will finally enable
me and others to catch those bugs (use wdt and pstore).

This series adds Tegra20 watchdog support to tegra_wdt. Tegra20's boot
ROM hangs if VDE partition is off after warm reset (for normal reboots
this is handled by 8f0c714ad9be). The series offers two mitigations:

- By default, tegra_wdt stops the watchdog for good before the
  partition is powered off for the first time, using a new PMC power
  off notifier (patches 5 and 6). A watchdog started by the
  bootloader still covers the early boot (until PMC driver comes up).

- Booting with tegra_pmc.vde_always_on=1 keeps the partition powered
  on, so watchdog is fully usable at the expense of higher power
  consumption.

This has been tested on ASUS TF101:

- with tegra_pmc.vde_always_on=1, watchdog stays on, the device has been
  idling for more than hour (heartbeat 10 s, pinged by userspace every 8
  s), no issues encountered. Suspend/resume works. On timeout device
  reboots normally, u-boot still works after warm boot, Linux boots.
  Tested both with userspace opening watchdog device without pinging,
  and by crashing the kernel (panic=0).
- with tegra_pmc.vde_always_on=0 watchdog is permanently turned off when
  the PMC driver powers off VDE partition for the first time, after that
  userspace is denied opening the device with -EBUSY. No issues
  encountered.

Another series for fixing some other issues with warm reboots (not
related to watchdog itself) will follow shortly.

Patch 4 got flagged by checkpatch (WARNING: ENOSYS means 'invalid
syscall nr' and nothing else). I kept it as-is to keep consistency with
existing stubs. If this is not desirable just tell me.

---
Patch 3 depends on patch 1 and should not be merged before or watchdog
driver will conflict with clocksource driver.

To: Daniel Lezcano <daniel.lezcano@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>
To: Jonathan Hunter <jonathanh@nvidia.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>
To: Guenter Roeck <linux@roeck-us.net>
To: Jonathan Corbet <corbet@lwn.net>
To: Shuah Khan <skhan@linuxfoundation.org>
To: Randy Dunlap <rdunlap@infradead.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-tegra@vger.kernel.org
Cc: linux-watchdog@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: clamor95@gmail.com
Signed-off-by: Artur Kowalski <arturkow2000@gmail.com>

---
Artur Kowalski (6):
      clocksource/drivers/timer-tegra: Keep Tegra20's watchdog timers free
      watchdog: tegra_wdt: Move SoC specific parts into match data
      watchdog: tegra_wdt: Support Tegra20
      soc/tegra: pmc: Add an option to keep the VDE partition on
      soc/tegra: pmc: Add a partition power off notifier
      watchdog: tegra_wdt: Stop on Tegra20 VDE power off

 Documentation/admin-guide/kernel-parameters.txt |  12 +
 Documentation/watchdog/watchdog-parameters.rst  |   5 +
 drivers/clocksource/timer-tegra.c               |  40 ++-
 drivers/soc/tegra/pmc.c                         | 158 +++++++++++-
 drivers/watchdog/tegra_wdt.c                    | 330 +++++++++++++++++++++++-
 include/soc/tegra/pmc.h                         |  19 ++
 6 files changed, 540 insertions(+), 24 deletions(-)
---
base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
change-id: 20261108-t20-for-upstream-497bc765188c

Best regards,
--  
Artur Kowalski <arturkow2000@gmail.com>

