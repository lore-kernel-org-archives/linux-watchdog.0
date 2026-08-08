Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923912D7DE7;
	Sat,  8 Aug 2026 00:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786149847; cv=none; b=sn/ojN4wGyRRfQPxn7EOuTXYW+ibDiNe/5xUQBwg0WIgzvkOjAfSht+LM5Cp6UFqc1GLybZsxiXl4BKqPvH3ZVQL3eEPW5gWGiL0lsWh3qm+TC3FXiTayVw9Oiujl0ppi3/TF0vVH6hkNe1MIdqPakiyCkQmrWFCHLLXcRYDBPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786149847; c=relaxed/simple;
	bh=wAAOyLee9obcUEDB07bi3VXhTBhL/VhJbiH6BOBL+xM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PelRcPDQ+LE9q1QN259Nf531tgZfXS4Hnfr1Va9x1rb+8N0ZKQunQomm4Ztrb/gdi3DxBP0f6bAlKFTuuiFfcYcCzPZDELV2/mVRIuJJw33lkV8l6DxDUfC/R0JK8WvRyCr9f+UQsKnVXJwjL4ffokxJXdARVObF9ijRtt9bZLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IffwUP4Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IffwUP4Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3092D1F000E9;
	Sat,  8 Aug 2026 00:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786149846;
	bh=MsIX62jqPs2c/vautCRRYse4MtcBBM42Tru3D2QHabY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=IffwUP4Q91UkuSprMsWgqSLgm0l4BQN72lk/LU28Lwp5ijLX8NENyM6lu2XtKKu9I
	 uUXqyqX/HcUcC1xoL6Wf0Ao5JcHTjbR8FMv8aJKFFOgEKu9Zf7lxB+KEA+2xBZ8mea
	 piQp1YcKGBgWl0uTqwf/vGKvfGZYuTNB2NzJzEVmmpX8kW/YrZCvf+4b4mKSOhyqKq
	 T2O2J6btFmSf+L0XHXCaXCn/X+bSJ/3OHpySd2tHMo2eKoOiqAaBb/Tgyhk/pgf9xk
	 d9tvpf7ahO15HUxMbB7ojE1g4viO24A0ryu1lDFHoNYZJ4NL9r7Rmbw6rjjXeaTELv
	 W9wOp3mIW95Lg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A38380CEF9;
	Sat,  8 Aug 2026 00:43:25 +0000 (UTC)
Subject: Re: [GIT PULL] watchdog fixes for v7.2-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260808001514.2405698-1-linux@roeck-us.net>
References: <20260808001514.2405698-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-watchdog.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260808001514.2405698-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git watchdog-for-v7.2-rc7
X-PR-Tracked-Commit-Id: 8444d66aa6b6e7fe0a26fa1a00a11cb4d0523783
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a59f57e2aa127c5354168d2ec4bac920df1be4f4
Message-Id: <178614980437.2480932.6690849248199274191.pr-tracker-bot@kernel.org>
Date: Sat, 08 Aug 2026 00:43:24 +0000
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  7 Aug 2026 17:15:14 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git watchdog-for-v7.2-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a59f57e2aa127c5354168d2ec4bac920df1be4f4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
