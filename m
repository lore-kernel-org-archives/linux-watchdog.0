Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C903BBFB6;
	Tue, 22 Sep 2026 14:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088142; cv=none; b=DpLbg/MvxDIDxRM3sxjsQWqruQUjXN0cnh2Qk6aOZvbtxNf9gdII7KsnGRpQqXWJNnhvgtPdK/6Bf/JcGzau49/LDRpZzKYUDI4Ymd9jLXmqVWNLn2YyVoR2AkSnXoXhlkuSnzhjiz3iadM+RgAqQeTxNV2KOjbr0PhSpl53Tk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088142; c=relaxed/simple;
	bh=8XWsRdIFUSABcQNvjha7hbsJNP1sQGmpZpslRSpb820=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=OdtKL8vxCgf9RZrE/KYtK5rRwpMMZnWxpH7m9Nx973OZTxqpQutBux/yLbxdRgPSj/4kVx/BqKEKEDEgNhqj53Qv5QfwIy6eq28Yd2DhuG6VFk2HH5VnUrGuHl45VcDmI22yiPUq5nas68pyTxVADz1JhLPvMQAN95wCGqtKiNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.helo=mail.mainlining.org; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.helo=mail.mainlining.org
Date: Tue, 22 Sep 2026 15:41:52 +0100
From: Bradley Morgan <brads@mainlining.org>
To: Petr Mladek <pmladek@suse.com>
CC: Andrew Morton <akpm@linux-foundation.org>,
 Jinchao Wang <wangjinchao600@gmail.com>,
 Craig Lamparter <craig.lamparter@hpe.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v7_0/6=5D_panic=3A_fix_panic=5Ffo?=
 =?US-ASCII?Q?rce=5Fcpu=3D_redirect_races_and_NMI_bypass?=
In-Reply-To: <arJ2KqCA7aBgt71r@pathway.suse.cz>
References: <20260916182957.7788-1-brads@mainlining.org> <arJ2KqCA7aBgt71r@pathway.suse.cz>
Message-ID: <6FCE58E3-B367-4258-8852-EB04335F9590@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 22 September 2026 13:35:54 BST, Petr Mladek <pmladek@suse.com> wrote:
>On Wed 2026-09-16 18:29:51, Bradley Morgan wrote:
>> The panic_force_cpu= parameter redirects a panic to a specific CPU so
>> the crash kernel runs there. The redirect code in panic_try_force_cpu()
>> had two races and an NMI bypass, all found by Sashiko. This series
>> closes them and kills one more hack that the rework turned up.
>
>IMHO, this version is ready to go. It would be great to fix the commit
>message in the 4th patch but I think that Andrew could do the fixup.
>

Akpm? Up for it?

>Best Regards,
>Petr
>

--- Thanks!
"I'm not a very positive person" - Linus torvalds
