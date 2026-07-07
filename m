Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D77C38E8BE;
	Tue,  7 Jul 2026 10:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783419494; cv=none; b=WfxcYQdAYHu903oOZsmByqauga+IdJYjs9MB31MIbSkAQrRzc7NE+m9JERqzkiPe9uAJdT3BTZXFiKlLUvQhjPs3sBL4oByjK6iPv/ku/lZAXbaMHgzQAyQTU9U9SfKb2ze0tysntpwg3aDjLOvp5FrqD6BLYzKOKVKZAoxMZGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783419494; c=relaxed/simple;
	bh=u+Dd3Ym2PdPJsp/ejcuh3zKgHUyuIvnmV3NHhz1X0K8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n2ATtF/h4Xt9KVsnuWPVeUqmTfBnnqfqvckuoMK0TqfvAESLH1WmcjvxE10S566VTbqjEVBII9SpDEFxqAo3YlbIqNm3Q/DacUd+Kf4vJfQyJXW1dPOOjF2gzEu4UKzO2polgyPtXhd9nrLdEULFYr0M2+Y3CZnCMdSMhxW40zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hnw8hPmg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hnw8hPmg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9DC1F000E9;
	Tue,  7 Jul 2026 10:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783419492;
	bh=ylYhXURXRgJBX9/4ChaluiVfa0Om9yKIIy1I0NWmAqM=;
	h=From:To:Cc:Subject:Date;
	b=Hnw8hPmgv/hHI3TlHCjogcV98alJ00ZRuYrFiBmkr2/IbF34VdOybGUy1WKKnxK+X
	 zRUkbQiVtuZvJJ1qb46QmZVDnLmTLTmLE/ZU7CA8scXNoMzH4RhbgqiY4wiD8BZyGX
	 xTWMrBpExsQMd70yH9Ou32dkTajeStSEg10ig//w4Coml/L1mB+wsb++CMDNKCKkZl
	 WmUjgtcxEJDs1XMdbNEDv3NzzVzJ09oFcHky8qVFAAqgagSQTufkKbv4xjVwe41gl7
	 n4R6n3KSZ9wtFkyZyfyL4pi66s4UhglrIjElLC1j92xzzFo7iAzGUMhHmWizoH4G8x
	 6prWkwim2tCkg==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tzungbi@kernel.org
Subject: [PATCH] watchdog: pretimeout: Fix UAF in watchdog_unregister_governor()
Date: Tue,  7 Jul 2026 10:18:03 +0000
Message-ID: <20260707101803.3598173-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.55.0.rc2.803.g1fd1e6609c-goog
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a watchdog governor is unregistered, it updates existing watchdog
devices that were using this governor by falling back to `default_gov`.

If the governor being unregistered is currently set as `default_gov`,
the `default_gov` is never cleared.  This leads to 2 use-after-free
issues:
1. New watchdog devices registered after this point will inherit the
   dangling `default_gov`.
2. Existing watchdog devices using the unregistered governor will have
   their `wdd->gov` reassigned to the dangling `default_gov`.

Fix the UAF by clearing `default_gov` if it matches the governor being
unregistered.

Fixes: da0d12ff2b82 ("watchdog: pretimeout: add panic pretimeout governor")
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/watchdog/watchdog_pretimeout.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/watchdog/watchdog_pretimeout.c b/drivers/watchdog/watchdog_pretimeout.c
index 19eb2ed2c7cb..02e09b9e396d 100644
--- a/drivers/watchdog/watchdog_pretimeout.c
+++ b/drivers/watchdog/watchdog_pretimeout.c
@@ -167,6 +167,8 @@ void watchdog_unregister_governor(struct watchdog_governor *gov)
 	}
 
 	spin_lock_irq(&pretimeout_lock);
+	if (default_gov == gov)
+		default_gov = NULL;
 	list_for_each_entry(p, &pretimeout_list, entry)
 		if (p->wdd->gov == gov)
 			p->wdd->gov = default_gov;
-- 
2.55.0.rc2.803.g1fd1e6609c-goog

