Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF1E3E3177;
	Fri, 10 Jul 2026 08:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783671234; cv=none; b=pmJDKbQZcOt6k7KgL3IKYlnjp30vWqkMyQdqjVCozUSmxlcbd3+Egwh0F3ytpJPf62eqtDl9E6uuHMcBgvk1d2tKQDQ3nPMFlrLbqNOPwhq+NUO6T7o60af2LnOLfqkrCTIvcYsaCm1bs3L2JZMRQuNZX/2YThg1ab01xk0sLIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783671234; c=relaxed/simple;
	bh=yY09AEmvVtfeOEwcvLN1eHQxQMCiHZdGDkgX3KBtUB4=;
	h=MIME-Version:Date:From:To:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=QUhlyP4EExh0NCp0m70Sfc0Fv1AzcYCNQ6gHa9LjKsHyjwJZ1WO6Tz0zIJ+v+PTRRXz7KBU7V5oez/0Ff0Y0l2BOYMy3A/gsKXHiVGEQaUrcxM7t/3CSj4JHkXzMhHgirO99mD1MLuzvlPaC0AcIQptfFK9StT0z3BzYWyXod/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=ftsFZPhX; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="ftsFZPhX"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id C659386EEA;
	Fri, 10 Jul 2026 10:13:50 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q_6yLYmDoyjf; Fri, 10 Jul 2026 10:13:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1783671229; bh=yY09AEmvVtfeOEwcvLN1eHQxQMCiHZdGDkgX3KBtUB4=;
	h=Date:From:To:Subject:In-Reply-To:References;
	b=ftsFZPhXEffDVA5Nu5w1bpBpryPH080ct/R8pyvVEGbnR0iZ4I3q/siCB/JwMGxuF
	 PTYMj1BW0KFjJiKFSdsa91wSiC5fGgRKv4NztZlTzwaTOPIv+k7cGCDooTqaw6dvEH
	 B0C8nXyEVRANJpeGV9hSvzGbwiceEr/3XGgQ5kTmCn99x1VFN+WGpsbprK3qyctR/n
	 2jSyUwe5sikuS46rr+A6alujEHayrjFf9qoyG/Zq8klKLKRzuiyomYUDs6CE8+77H1
	 JltMHSsofPR2qaIW7bXVjViSu+p4J4CFF2KxW5Bx9QJKPH1sz93G2EEdSUkLAOibwu
	 NJ9GG0dWFdidQ==
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 10 Jul 2026 08:13:49 +0000
From: Rustam Adilov <adilov@disroot.org>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, Sander Vanheule <sander@svanheule.net>,
 linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/1] watchdog: realtek-otto: Make use of regmap API
In-Reply-To: <20260710074316.46643-1-adilov@disroot.org>
References: <20260710074316.46643-1-adilov@disroot.org>
Message-ID: <79ff8becf68dd80b8993a458ae7e3c44@disroot.org>
X-Sender: adilov@disroot.org
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 2026-07-10 07:43, Rustam Adilov wrote:
> This patch series changes the driver to use regmap API for all of the
> register access stuff instead of the ioread32 and iowrite32 with __iomem.
> That makes the watchdog operable when SWAP_IO_SPACE config is enabled just
> by adding big-endian property to the device tree node.
> 
> Also, there was a comment by sashiko which got addressed by Sander in [2]
> with possibility of it being false positive so i left it at that.
> 
> ---
> Changelog in v3:
> - reworded the commit message to make the main reasoning clear.
> - rebased the branch.
> - Link v2: https://lore.kernel.org/linux-watchdog/20260519182329.24472-1-adilov@disroot.org/
> 
> Changelog in v2:
> - removed patches 2 and 3 that add rtl9607c device.
> - included driver changes made by Sander in [1].
> - added disable_locking to regmap_config and set it to true.
> - Link to v1: https://lore.kernel.org/all/20260509163101.722793-1-adilov@disroot.org/
> 
> [1] https://lore.kernel.org/all/20260515212351.752054-1-sander@svanheule.net/
> [2] https://lore.kernel.org/linux-watchdog/d0b159eefa6bc5abf0d1531acde568396f480500.camel@svanheule.net/
> 
> Rustam Adilov (1):
>   watchdog: realtek-otto: Change to use regmap API
> 
>  drivers/watchdog/Kconfig            |  1 +
>  drivers/watchdog/realtek_otto_wdt.c | 74 +++++++++++++++--------------
>  2 files changed, 39 insertions(+), 36 deletions(-)

Hmm, there is a real possibility that Guenter Roeck didn't receive
my patches because I've received a message "Undelivered Mail
Returned to Sender" indicating mail host roeck-us.net has rejected them.

I don't know if that's gonna be a problem but i hope not. At the very
least it is visible on linux-watchdog mailing list.
