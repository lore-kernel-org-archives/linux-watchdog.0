Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0284914A62F;
	Mon, 23 Sep 2024 22:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727130880; cv=none; b=K6PfQli6tiAMs236lYMIGKOf2+LTKGf3n1eKK+UuaC1hc7uKD+1EGvDdu7Kb28FJKYJaJWeKK68VTRV+j0qcgMyzyqnsX1Gbls28T3FhE8YasAldBRdQb7jB3RGlNp3XgFGL+S7i6uHcbyI30nRRtWJDO8qcj3xkUkQI9Y5KIcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727130880; c=relaxed/simple;
	bh=4t76kJGzDtHS8fuEWAELTq1eRSbhzpPx8GSUyTdweY4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SOwndVm+eGfxMICLsvbBb80N0usWxkPAxCvlR92vLCs1H68o/WGlUm717vdMu1+6h+8EIjrWoNv2hIoDYJWvcdPjd5y/u43BjtJ2pTMKW0/fEC8yoD9xhunRu8GsKEHN0RIziPe/KqWZHAWNuO8bizGlHDB7odXNuzgNf0LO7+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vCPHfH4c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCPHfH4c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5DC2C4CEC4;
	Mon, 23 Sep 2024 22:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727130879;
	bh=4t76kJGzDtHS8fuEWAELTq1eRSbhzpPx8GSUyTdweY4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=vCPHfH4cqsvT3+U5YkxToCP2+hlqCa8lhFVImohrDcyaPy9DC8ZylorYMUGmh0y1s
	 1N7ijtiwcIOh0UA8eF2ahQErDcuD9TPO94fglOq6SBameBxCcOAeJf7gjB22orO5Kg
	 5FLBzWqx0OQyIyn76462bSkMzSBBfDpZiedMs/Px4dJdDnMZtiDLPk7AWB1dYoXvbB
	 xtMYRmDGjoy8j6qhrChTcOkcHAFD88rLvah0lO44cE3nU6hBbLlu2MdJpIgJ6OLrRE
	 79tGwua8CZeyUv3Tm3sk88H5SwpCKTKslK6m2T7MLdEPrAebMNbFwsg2cuvbRfOzXW
	 OMuwNAQs2xM6g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E9D3809A8F;
	Mon, 23 Sep 2024 22:34:43 +0000 (UTC)
Subject: Re: [GIT PULL REQUEST] watchdog - v6.12 release cycle.
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240922095341.GA1554@www.linux-watchdog.org>
References: <20240922095341.GA1554@www.linux-watchdog.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240922095341.GA1554@www.linux-watchdog.org>
X-PR-Tracked-Remote: git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-6.12-rc1
X-PR-Tracked-Commit-Id: 134d2531ef82043e8bf219497a4f1eb8fe21a6b7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f34c51252189e6f18f3983f7cb7cc46f2e54ffe9
Message-Id: <172713088205.3509221.6951445322869167780.pr-tracker-bot@kernel.org>
Date: Mon, 23 Sep 2024 22:34:42 +0000
To: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, Alexander Sverdlin <alexander.sverdlin@siemens.com>, Chen Ni <nichen@iscas.ac.cn>, Fabio Estevam <festevam@denx.de>, Frank Li <Frank.Li@nxp.com>, Jonas Blixt <jonas.blixt@actia.se>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Marek Vasut <marex@denx.de>, Nikita Shubin <nikita.shubin@maquefel.me>, Shen Lichuan <shenlichuan@vivo.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 22 Sep 2024 11:53:41 +0200:

> git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-6.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f34c51252189e6f18f3983f7cb7cc46f2e54ffe9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
