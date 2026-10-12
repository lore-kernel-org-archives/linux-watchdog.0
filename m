Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A321423B63E;
	Mon, 12 Oct 2026 00:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791766026; cv=none; b=aRTnBreWwasIsjrqUzuQYkTFgTLLk7l1JzXr7sJxhrnR9rf8lz/tpuhLM9p/r5yokTImUErCDe7nYVHBHuH8tWBoj/05yLjFNVtxEebvkJxNy5wL4iYr6/AT//WaTX8WoPZaXivaiKKiG3xWWoS3qHX5Z+TzJy4QLGenWaggXio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791766026; c=relaxed/simple;
	bh=QvXw4q3YNI7WdpHXkrsI3WgjEitXRqf5xOTiIc/VBxQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lQ3INmUNb4UZYkY8ZNtofqWv5kOzIATJKSCTkl6pPWVie2gf2k89AI/eHbLadgZHPnolX0EJrzefHOHeWKcVUujj/kLRjQn/HCPt8ADJZnW3DbiSP87m2MlGWh4Aw6qOPH5WFO9775gWNS5OX1rm0+j5C1bNoaMLnEq+oUeZDhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmMVVyqG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmMVVyqG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A050C2BCF5;
	Mon, 12 Oct 2026 00:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791766026;
	bh=QvXw4q3YNI7WdpHXkrsI3WgjEitXRqf5xOTiIc/VBxQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=RmMVVyqGmIehdlDEjcXmU53ULd2LX9rFL2Q+a5M7CQ19rFnpDwdAE6X9DKhEhaXEY
	 gnz5f7OSqUOSWR/ghACJin0k0u3cOapFcOC2ZZF5uN3NPy8EvoHP0A0jpO44MyMW/c
	 Cq3pVTv5BcQf0deeTAB1GbQE6qJLZfdDDrTaheuT6MpbYCWsomvRxabqr9wzR84akM
	 RPWH6YP2ZGNQpotW6rBMQRyX3uNrehCbsCdiExtojUeRvhyikhisnDH+1nvqecjn4s
	 Iue9D8fbtUSIrAjkBoJhIssFhp9l6RCGNnPnxFLHb8NfW1o8+go/0vMnvq7Hms/7tW
	 43UDmvFfY//hQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B99CA9ED2;
	Mon, 12 Oct 2026 00:47:06 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Subject: [PATCH v2 0/2] watchdog: orion_wdt: stop the watchdog during
 system suspend
Date: Mon, 12 Oct 2026 03:46:55 +0300
Message-Id: <20261012-orion-wdt-suspend-v2-0-f13cf71443ba@iav.lv>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAuzGoC/32NTQ7CIBCFr9LMWgxMDFhX3qPpAstgJzHQQEVNw
 93FHsC81ffyfjbIlJgyXLoNEhXOHEMDPHQwzTbcSbBrDChRK6lQxNQS4uVWkZ95oeCEPHs02lp
 v1Qlab0nk+b1vDmPjmfMa02e/KOrn/lsrSjRpo6eb6Ql7urItx0eBsdb6BdABR9yvAAAA
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1555; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=QvXw4q3YNI7WdpHXkrsI3WgjEitXRqf5xOTiIc/VBxQ=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFln9Nj9d6nW/eisXd70bIXfhBj/HwX/dSM3+xUGuDcb/
 OuvCRPqKGFhEONikBVTZJlwSONWxpKrf/09zB/AzGFlAhnCwMUpABNJ5mb4MdX5QmxOiwiTb+H2
 7ZafC8VuWsx7/OaBrBjvrIKUee+tGf4KfRS3/7pjg9gK66t9r5qM/WIO/3K/smnVpLx0sykV0aZ
 8AA==
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Reply-To: iav@iav.lv

The watchdog keeps counting across system suspend while the userspace
that pings it is frozen, so a Kobol Helios4 (Armada 388) resets 60 s
into s2idle. Patch 2 stops the timer on suspend and restarts it on
resume. Patch 1 fixes the Armada XP pretimeout that Sashiko spotted on
the restart path of v1; the same bug hits every start since
7a6b3d8a432d.

Tested on a Helios4 (v7.2.9). Unpatched, the board resets 60 s into
s2idle. With patch 2:
- watchdog daemon: three 120 s s2idle cycles, no reset;
- systemd RuntimeWatchdogSec=60s: one 120 s s2idle and one 120 s
  standby cycle, no reset;
- the watchdog still fires after resume: freezing the daemon (SIGSTOP)
  after the s2idle cycles reset the board in 61 s, a panic after
  standby in 54 s.
Patch 1 is compile-tested only; I have no Armada XP.

Signed-off-by: Igor Velkov <iav@iav.lv>
---
Changes in v2:
- Add patch 1, the Armada XP pretimeout reload (Sashiko).
- Keep pm_sleep_ptr(): it is the pairing for DEFINE_SIMPLE_DEV_PM_OPS()
  (1a3c7bb08826).
- Link to v1: https://lore.kernel.org/r/20261012-orion-wdt-suspend-v1-1-1676cb79e29e@iav.lv

---
Igor Velkov (2):
      watchdog: orion_wdt: load the pretimeout counter on Armada 370/XP start
      watchdog: orion_wdt: stop the watchdog during system suspend

 drivers/watchdog/orion_wdt.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)
---
base-commit: 8b5a9f09037e3c372c4e9f2fbda85fcfbf5ea5f0
change-id: 20261012-orion-wdt-suspend-08f276aafa14

Best regards,
-- 
Igor Velkov <iav@iav.lv>


