Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C628F3B2FC7;
	Tue, 16 Jun 2026 02:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781577908; cv=none; b=pUgGxH2Gr2F8e1L2JhRfFXOtAKPAlWb/bxNSem7rgVizJb+vbODyDNxx1FfSmZQg3GKnnf4ygoBNMxwVbfSwviI3lCbngQD3b3l/geIFdf6As9nj912w99L5p5RnygvTp2rarrVdapI6iSMacVDJBvaK54LXYYoW4QKV7lSibks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781577908; c=relaxed/simple;
	bh=ZKxJ2ZbPD4G7plROF2gQvXZAYn9jo0lHPhZVlJzDZ0M=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WybNELmWi87o9t02bhSMoJzoz0M/Ru+bkm2qBFo0WztArFZVdzOHWVag10zPPZ6nTzlcqD9oM38MO2MX5Khtsr4Yl3Qr9zJQFEsQenuRmViR3fh/NnqKtjM6jXO5ZASmIp/J0rM/dGMNlVCWT9DhnslT458n7dBDMLHHIVwFR9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8iaBlyV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8iaBlyV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD871F000E9;
	Tue, 16 Jun 2026 02:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781577907;
	bh=RkONr6qh54+zDfLmacHmQ3dSGdtxbepZUZylayhgL+4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=I8iaBlyVXJl9Hwlq5AwlEcqMMwRSj+wjayWpSLR5bQ42pjzx9HV4rP61xeclbRmtD
	 gnEO7dapLQGNpzHW7bWhh3rny9nRCHVffSLwuv9/Qi+nMhEkaft3jEppW3hA45SvXX
	 QZK9F3FnKzYiiegv/huIB5XFqq6QsUDI3xvgjve+wBdZ8XYScJtEHWI1H05NxY+sSV
	 nEcIgt81U7/VqCn7HQobmP4pV19UGjPaLJA69dRjp9oZvQpHp9TTGHl+IwsmeBqtPh
	 P88IHKuOKZtAYSyYsHpj6udS+NXpstBrcY3FOGMZv/1oiEcSyvZRJQzpedW29hukEt
	 eJvc4jsHE/Azg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09E43839A26;
	Tue, 16 Jun 2026 02:45:03 +0000 (UTC)
Subject: Re: [GIT PULL] watchdog updates for v7.2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260615140545.1954844-1-linux@roeck-us.net>
References: <20260615140545.1954844-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-watchdog.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260615140545.1954844-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git watchdog-for-v7.2
X-PR-Tracked-Commit-Id: 54c726fbb53341a2553bf234d519d0cb22a2ce3d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7e54cdd0564f5393eb773b88cb49f55859e90474
Message-Id: <178157790238.405554.1946650664438294091.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jun 2026 02:45:02 +0000
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jun 2026 07:05:44 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git watchdog-for-v7.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7e54cdd0564f5393eb773b88cb49f55859e90474

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
