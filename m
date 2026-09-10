Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49283D6CD3;
	Thu, 10 Sep 2026 21:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789077221; cv=none; b=N0NANqIdp5K4zBA7f8WqKWZNzgu3zwhmSPr11ZYRuNhLq2ccAkMNqiW/+2FoZLeNOeHn2GlgGuHwmGdW2Y6mtSRld3FSQaIAKu/HaCeN0ZnYEXOOPFWzeR6YuyFHD7gK1LvZviO5lHcPTIH0Kdvn/vciF9jTAc2rxfHPSKpcguY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789077221; c=relaxed/simple;
	bh=VJBhayoy06rfNd91y+p8HBMN1/zhNwXBmviM8Es4B18=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QtstbZnl2z47yl+vrZw9XHFViM/ppdIAvRhbAU6x7AiZ+yaxWOt9iVBHMfYI3kXZ1pZv5v5oecG0Q2g/OLY3yv0UWuuZ4di8E/eLtTwkjk1ycRpWJ6C6JAb0gfpr70Pb7y4aQPLGNskAWfdfWHU+a1lcMiOYGv4RpHykBONRzFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fF0cfkoD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fF0cfkoD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA58F1F00899;
	Thu, 10 Sep 2026 21:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789077217;
	bh=JKceiLQcX0msvSGaiO4zjbvexeNqzYnz4x9nrfSpi/c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=fF0cfkoDqFS73LRblt6bGGTqT3T+4J3jmXSgBF5h+5aHaLmC8gZvdHA3u7OwFVaYL
	 +EmxQF7BR4Cg0MWSp1VRBRJFydTFcURPy6/1eBDpFLyQxZHoBKmC6DVd5ohAVkmth0
	 YOSkQi2t/hZE9KFuwRQhbHUALBbyoHX9liSlWXH5DFmvUbmaoRIVxTzIjvBDLPbLSR
	 hgWhViZbxnuNDiJXz4DjePNT8eKB8GSks8QcS/pUC4MYUI4d+ighJDPYwKwDaMe/QN
	 X4FFUga+hKJ6Y2C9Apbuwr2DIZ1wWkOfsHxYAsm5AQusoTff8XQj6aZuu7kDP8JAa9
	 nra06VNXk3h5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56C29380DBDD;
	Thu, 10 Sep 2026 21:52:36 +0000 (UTC)
Subject: Re: [GIT PULL] watchdog fixes for v7.3-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260910011406.951178-1-linux@roeck-us.net>
References: <20260910011406.951178-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260910011406.951178-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git watchdog-for-v7.3-rc3
X-PR-Tracked-Commit-Id: 01504d14e47b34779911250dd308a03f6ef681c2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c9a8c0e393d6043fc29b0b527e654110ba523c36
Message-Id: <178907715500.2100681.3735844180099026225.pr-tracker-bot@kernel.org>
Date: Thu, 10 Sep 2026 21:52:35 +0000
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

The pull request you sent on Wed,  9 Sep 2026 18:14:06 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git watchdog-for-v7.3-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c9a8c0e393d6043fc29b0b527e654110ba523c36

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
