Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973DA2494D8
	for <linux-watchdog@vger.kernel.org>; Thu, 23 Jul 2026 16:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784823372; cv=none; b=eDWW5uOxxpZzN8/HdotSW3hk4KCp7WsM24WuZKuS1LUf1R3ZJPMpEJxHvoKlUNIadxDHFJYYzaqPb9ZgtVJ93Txn+Nj5hFNQCoEJ26gOjOFgVPreW5iD3BdJsA7hdp6n4/g/3acx+6W2nzdwOcFSR+nOyS2y0KWyvfM9lCyK5ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784823372; c=relaxed/simple;
	bh=RhYZhATafjoMD0ZHXlRQHWN9Xd1AxMAMGtvwpmw4tCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MOqF/HcvKvXo2EBQvsCzhrbd4gLXD8qXKH4Z/Or/mDsFLDs35Mbx5Eg6nS+aYYe/oyOnlhIrsYsAJaSpx7KMMjQJpsTH7k1UuAkMSTwfShH2nPMAwIsjYlZhtBf2JWvnRa680M/Wg5xFHnHWyjg8IcxI9WWVYRCQZprd48HirIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9Mxu893; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9Mxu893"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39c95395230so7839651fa.2
        for <linux-watchdog@vger.kernel.org>; Thu, 23 Jul 2026 09:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784823353; x=1785428153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iCFBAhStYCbZRWF7EYeTGTDCTAg3SzAm66lZxtMyduE=;
        b=A9Mxu89328xZTb6bSW/2wNnD+XEPmPHz3atfPhfCpmbOOVGSlflpXV4Jqm8nl+QhHh
         7N3M/cilFKg91h9GOQ8CRh60AdSOd4wphKO07Gtin7NnpmNVTlVzWEtl3ycmlzS3HtY5
         cdNuZX43vZUKpuFTo10Ai+KkbS6lzqDgcLbYAyXjez0Ddmix7VS0IHyFgyofPQAtK92q
         sVZ2DeSCeif8AfuWHSVTD/Dchg2oH+QgqWIFY0xfNH2J8Dp/UMTJgOTHIR9TQ69RQlbf
         ieLiBus83V/lNa8A6HcLgmFwmhO8pGIv3ddMtIaZiexwpZWHh4q/W5nSQI2XVeD7Nlb9
         0ngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784823353; x=1785428153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iCFBAhStYCbZRWF7EYeTGTDCTAg3SzAm66lZxtMyduE=;
        b=TgXBjA66ZKa3UVUdFg1gbNCFi+AL5oC0Ep3EuRfuX13yc3bdziCwmwrzHy70YBMLxP
         VwyBMbtp3y2yadvEKBUszzqD/AGSRaM08cXihG/iYrw4pXsKaSy+RkfUt57txaUnpB9z
         PDYD4prZUJaBK8toV/jP9ReYeUlR/cq2Ns0x2Tx2PUyl/fToSdkX3Tqo4fXWU/NxlkaI
         AKXD30ELLM4rRlsUTRzRmV+t6f/pRahnSH36umfot+29TGTtSJev3JPA6gp3DX+RH2la
         kSkB6B0OqaZ41CMrWZYS5J2XQ8GrX6E0byHxzMWawRmmpBrKTqCNu3k3PTRvzDfgqMmO
         mNow==
X-Gm-Message-State: AOJu0YyZ867XAhzmyG5L1lmgX+KU8cC6xY0U9bmXofgX/2ILsb476Ioe
	DORNWyY/D9fD/KscRNMDec5fNm+aYeTgRRAmoEEhMa6TXC3gJysMg04ZVnzUCSwQYes=
X-Gm-Gg: AR+sD107xg9FG48p7+lUoNXfR0Hk+PAwUsKoypnQk5Z12SM0moCGq4i7z9Qo69LsQgJ
	hJohXEfr3zCwW9kD0V+jxOLL74oJKGeni1EfpAGbRp9eyN2P3k6axUpOmPWisLTCaJXenRpcv7s
	S+2MCI4sY6Xtr0SirRGxgPdu1puy6nAlBJWIJWoyZwKqMD0buEQKHZSq+S2ZUC1k6lmTj+cRj/1
	dqnZaSlvlv1hZrH3AKuoIXuOg6wFEMsY0SAjgcNtGQUsGX6fBkLmsz1JwBphD09J1rObAl3gYV3
	3sMZy2zXda18YC3f9ij/YIrxyKIM5vUMwLVCx6Vh6bGqSWWIl543JTQfsshrQbGny7GBWm4LDvC
	FOGcQRcnETkkt40Xk/O5XuiQy5Y9s1zsRNnOas3CDazK+J/ZSr1d0nsI/P667s2vzCBaz+dxeYW
	CGhFpPog548fXFo/5fMF5bb6twbEPgCA/vExQNhV/lXYmwnXcdPLJChPRI0uX1ecKekZOEuq8qP
	69K
X-Received: by 2002:a2e:3a13:0:b0:39a:e29b:790b with SMTP id 38308e7fff4ca-39f07e96d46mr6427911fa.34.1784823352729;
        Thu, 23 Jul 2026 09:15:52 -0700 (PDT)
Received: from localhost.localdomain (46-138-176-102.dynamic.spd-mgts.ru. [46.138.176.102])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39ef6d8c40fsm9875561fa.41.2026.07.23.09.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 09:15:52 -0700 (PDT)
From: Artem Lytkin <iprintercanon@gmail.com>
To: linux-watchdog@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	wim@linux-watchdog.org,
	linux@roeck-us.net,
	ojeda@kernel.org,
	miguel.ojeda.sandonis@gmail.com,
	dakr@kernel.org,
	aliceryhl@google.com,
	a.hindborg@kernel.org,
	lossin@kernel.org
Subject: [PATCH v2 0/3] rust: add watchdog abstraction and Rust softdog driver
Date: Thu, 23 Jul 2026 19:15:26 +0300
Message-ID: <20260723161529.23759-1-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds Rust abstractions for the watchdog subsystem and a
Rust software watchdog driver functionally equivalent to the core of
the C softdog.

Patch 1 adds the watchdog abstraction: a Device wrapper, an Info
wrapper with option flags, an Options configuration struct, a
#[vtable] WatchdogOps trait with an associated Data type for driver
private data, and a generic Registration that owns the device, the
ops table and the driver data in a single heap allocation.

Patch 2 adds a minimal kernel::reboot module wrapping
emergency_restart(), needed by the softdog driver.

Patch 3 adds the softdog_rs driver: an hrtimer is armed on start and
re-armed on every keepalive ping; if userspace stops pinging, the
timer expires and the system is restarted via emergency_restart().

Changes since v1 [1]:

Most of v2 is a redesign addressing the review feedback from Guenter
(via the Sashiko review [2]), Miguel, and the kernel test robot:

- The ops table is no longer a &'static mut supplied by the driver;
  it is built by the abstraction and embedded in the per-device heap
  allocation, so multiple device instances need no static mutable
  state (Sashiko).
- Driver private data is now supported via an associated Data type;
  every callback receives a reference to it (Sashiko).
- Callbacks now take only shared references and Data must be Sync:
  the watchdog core does not hold its lock on every callback path
  (the first start/ping on open, the reboot notifier stop, and the
  stop on unregistration run without it), so exclusive references
  would be unsound.
- max_hw_heartbeat_ms is configurable and the stop()-or-heartbeat
  registration requirement is documented (Sashiko).
- Removed the Registration::device() accessor that allowed aliasing
  with the references used in callbacks (Sashiko).
- stop_on_reboot is now opt-in and rejected with EINVAL for drivers
  without stop(); nowayout defaults to CONFIG_WATCHDOG_NOWAYOUT
  (Sashiko).
- The watchdog is always stopped on unregistration so no callback can
  run after the driver data is freed.
- softdog_rs now actually bites: it arms an hrtimer and calls
  emergency_restart() on expiry, instead of relying on the (wrong)
  assumption that the core handles expiry (Sashiko).
- Kconfig mutual exclusion fixed to SOFT_WATCHDOG=n; !SOFT_WATCHDOG
  still allowed both drivers as modules (Sashiko).
- C helpers marked __rust_helper (Miguel), and updated for the
  const-qualified watchdog_active()/watchdog_hw_running().
- Fixed rustfmt and clippy issues reported by the kernel test robot.
- Drivers no longer use raw bindings: added the Info wrapper, the
  flags module, and the kernel::reboot module.
- Added the new rust watchdog files to MAINTAINERS.
- Rebased onto current mainline (post-v7.2-rc4).

[1] https://lore.kernel.org/linux-watchdog/20260323195138.5541-1-iprintercanon@gmail.com/
[2] https://sashiko.dev/#/patchset/20260323195138.5541-1-iprintercanon%40gmail.com

Artem Lytkin (3):
  rust: watchdog: add watchdog device abstraction
  rust: reboot: add emergency_restart() wrapper
  watchdog: softdog_rs: add Rust software watchdog driver

 MAINTAINERS                     |   2 +
 drivers/watchdog/Kconfig        |  12 +
 drivers/watchdog/Makefile       |   1 +
 drivers/watchdog/softdog_rs.rs  | 143 +++++++++++
 rust/bindings/bindings_helper.h |   2 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/watchdog.c         |  38 +++
 rust/kernel/lib.rs              |   3 +
 rust/kernel/reboot.rs           |  19 ++
 rust/kernel/watchdog.rs         | 522 ++++++++++++++++++++++++++++++++++++++++
 10 files changed, 743 insertions(+)
 create mode 100644 drivers/watchdog/softdog_rs.rs
 create mode 100644 rust/helpers/watchdog.c
 create mode 100644 rust/kernel/reboot.rs
 create mode 100644 rust/kernel/watchdog.rs

-- 
2.43.0

