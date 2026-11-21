Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795230682;
	b=fMNgPHC3wGmDXozSiWeV4XMaMdmj0Q+VQtB3xDmCXIPSTWFdSTpqZNB+Bq+JbeMCubbs
	 GTKeWlQQ3XaHdCj2QOoQRhbvCD/Ye2N68ctnJg+QCPXuwmjrBb8Tzdnm3DoNkRY44clSe
	 9FbZ1AbF/0ZclWb4/DCeL5OJyCyag232jZkRoq/cyZvkV659XHtAvf+GbfUL+j65bZhwg
	 aevde8JO5QkY7Qcj3LXWOx+oykRtkYpSd+J65u2/sb45EbSU29926c1xGlQh8IOqPLi5U
	 MpWthWt7GhsABfzHJAH8NllxNc4tiBrPHgV1th1EUgGqVz5ovSEj8uzyZ1KTRQ8OhVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795230682;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=NHAxAgLTJkd6gsLk8xE2Eyy+0nEMZ1auR5nTdU6TBxE=;
	b=izAukSl1aWM7YLm8GA4VHsEORHaukZdE/qfMUqS3gabHDbrl4TqnGFgwQT/8JUplNzVZ
	 qJanQSiHJz5PPL4DM1Avrukk3fRDa4g1702hYtURkGcqomSrXcB6LFxkzhpBjf71y/9c5
	 IV3XOd4phiUjtMygvzOI0qUc2rQkstUGbZwXHS5T7TfdEs+9T03tEeBGzLfP1TTt2NgoY
	 f7PD3yguWGj6ibx58nK1rQ6jtkraTSc13Yo10cf+Dbef5mz7v7xWEmCfM1/VUWA6Qax22
	 cdJXs9OPp0l1fD8urKRx8T5sxbQbP4kShIt89RL+OW9cVahxiKm6iUH+1AAy4h7S/fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ft9o5NHK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22343606A325;
	Sat, 21 Nov 2026 03:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ft9o5NHK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE5851F000D0;
	Sat, 21 Nov 2026 03:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795230681;
	bh=NHAxAgLTJkd6gsLk8xE2Eyy+0nEMZ1auR5nTdU6TBxE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Ft9o5NHK30y/MJDo/qrlDYT5+zIT7EtNOmSNfbtSGZp7U0Zleo/6SDFciJwJ7M7Ff
	 um9IyzJ7xGXQrhyyeN0DQNQ2RuEb98BMKXvvJjgeuo1BE+j8jLwyAckoejCRMrAL9v
	 pDbkqWgcTxSaCsDaFpe28+SK9vwXVzw3FI/vAaR3bjzJaJkprr3UVBQ4o10dKzZT14
	 1UJdLuvXcX3vCLdgbsXigdMVwyK2aa0CnX0m2S/rFk3KUfaP76ObmzpW2mxyhcYl2X
	 dKR9exbUYdSoBhKPQleqF0VVDXujAW3wBaiyuLNnrc+9dTTuccL5IWfkECdP3+0ElB
	 x4K2ANMPozfug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B4318380AAFE;
	Sat, 21 Nov 2026 03:11:21 +0000 (UTC)
Subject: Re: [GIT PULL] watchdog fixes for v7.4-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261120210527.799889-1-linux@roeck-us.net>
References: <20261120210527.799889-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261120210527.799889-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git watchdog-for-v7.4-rc4
X-PR-Tracked-Commit-Id: d8cda274400b52c5bb542158ae9f220f72f059f0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7d51f37ed48e11a0a073ec428abe9d61c4449072
Message-Id: <179523068040.902445.9674883946457006248.pr-tracker-bot@kernel.org>
Date: Sat, 21 Nov 2026 03:11:20 +0000
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Fri, 20 Nov 2026 13:05:27 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git watchdog-for-v7.4-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7d51f37ed48e11a0a073ec428abe9d61c4449072

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
