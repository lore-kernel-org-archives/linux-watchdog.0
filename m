Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1129D48FF80;
	Wed, 16 Sep 2026 18:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583420; cv=none; b=h3/PFDoLZskoOcCo7QQvc1U2+CduVCuTiBJXER51erY7Ke5/n4WEwtGr/3lCn2HWlIYhHhUIuWaSI3Rg8yRr0Wm5ncSJRjMsA0bttdw4zhL4vjAHDty0O0VbaHf0kSnw8VH1HrV/kYLMCeiH21I/jxf5NRVeFOU8tMsvZfLj8h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583420; c=relaxed/simple;
	bh=nzFtczIG0iPbwzyD/45xa8D51cfiPeDtUAtClNAdNzk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sfVllzie7DlgbCjOQJLkcazTUQ8+SSe1rdLW0QF2pTsvYyeBAbDamwmX0gNKs3yHO96hSODbSsp4vbAtHfzFaxZ+G4Bpjs3KUVt7RGXgjH0eKuol5SjNBXT7NyAbM2dcLnSva9gqXSTLfPuaguXSTwb16BrPVSg3dYjTbIolUx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.helo=mail.mainlining.org; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.helo=mail.mainlining.org
From: Bradley Morgan <brads@mainlining.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Petr Mladek <pmladek@suse.com>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Craig Lamparter <craig.lamparter@hpe.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bradley Morgan <brads@mainlining.org>
Subject: [PATCH v7 0/6] panic: fix panic_force_cpu= redirect races and NMI bypass
Date: Wed, 16 Sep 2026 18:29:51 +0000
Message-ID: <20260916182957.7788-1-brads@mainlining.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The panic_force_cpu= parameter redirects a panic to a specific CPU so
the crash kernel runs there. The redirect code in panic_try_force_cpu()
had two races and an NMI bypass, all found by Sashiko. This series
closes them and kills one more hack that the rework turned up.

Changes since v6, all from Petr's review:

Patch 4 now fixes the -Wformat-security warning that the __printf
annotation tripped in hpwdt, the closest caller: nmi_panic() there
passes a stack buffer, so it calls nmi_panic(regs, "%s", panic_msg)
now. The "every caller passes a plain string literal" claim is gone
from the changelog, it was wrong anyway, hpwdt never did. The
duplicate __printf annotation was dropped from the .c definition, the
header carries it.

Patch 6 dropped the "return value is not even checked" sentence from
the changelog. The kmalloc is gone entirely in this version, and the
self report on failure was deliberate anyway. The now constant msg
variable is gone too, panic_force_buf is passed directly.

Everything else is unchanged from v6. Patches 1, 2, 3 and 5 carry
Petr's Reviewed-by from the v6 thread. The double warning when a CPU
goes offline while marked in the panic mask and the set_cpu_online()
asymmetry in nmi_panic stay as they are, Petr called both not worth
touching. Rebased onto current master, the arch_do_panic rework from
Aug 31 merged cleanly on top.

Panic from NMI still goes through the redirect path first, so the
crash kernel ends up on the CPU the admin asked for. The redirect
buffer is a static 1KB now, no initcall, no fallback message.


Bradley Morgan (6):
  panic: fix redirect CPU race in panic_try_force_cpu()
  panic: flatten nmi_panic control flow
  panic: fix va_list reuse in panic_try_force_cpu()
  panic: restore variable arguments to nmi_panic()
  panic: allow force_cpu redirect from an NMI
  panic: kill the "buffer unavailable" redirect fallback

 drivers/watchdog/hpwdt.c |  2 +-
 include/linux/panic.h    |  3 +-
 kernel/panic.c           | 80 ++++++++++++++++++++++------------------
 3 files changed, 47 insertions(+), 38 deletions(-)

-- 
2.47.3

