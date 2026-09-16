Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA11352C2C;
	Wed, 16 Sep 2026 03:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789529732; cv=none; b=YjBiPyhaLelBLj2CaubyRE25KeyljOdVI6lROn+QRFXlkI1B/fNmsYNsjFoLt+HIBFiWYutR3z4BtQHT+W7fRZOBzuVVVxWKF4k8yCPQ++IBxdyVDGwxVQkHTTwyXw+Bae6IFB8hp6QFdbMwGJKMWGWkYKIgIL+s6VyxvNYfHho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789529732; c=relaxed/simple;
	bh=s+fdrPNS6x+20oT56UkauUL9ME5Wm+5wlUEcyw5bmBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FU0DMvLRMb2ReupMRDHq/7Lv2HKM+J+NgmO+nxV2h2Nn3OFTrzV8ljUsLAvLyxkKdxRf/iv1atc7lux9ZUYnIfZDkjRsaNF+KC1E3uXMR5SaOdydCqVPAPJySiexqXiSSlf6VnelFWw0lrMNnyYaAXB6uCrDpFa9ZJO4RZkmTbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/puGvZm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/puGvZm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF3E1F000FF;
	Wed, 16 Sep 2026 03:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789529731;
	bh=SJ3v2DF77dbKrp0U9rt2hNGYWQgw73HxBJuHXMze2nA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j/puGvZmMODRm13nyLY8HJYx4x4WTW0A0cSkzGzM8uwuE81sFb5BFjk2PRK0rQa5M
	 vzcFA4SjYsgqQw59nMSBOYsxQpTkUa5Z2GWJjtMONo5ojUVbJdv7hyQqqC7FhmxWX2
	 fc1atN5+rqERRnCBUqqsPAQDEA9iPtbIaJiV9QzFh8MVtQuFxfUh6vvjaRzZ33jmqT
	 24wi6day2X3Qo3YQ79mxFG5G3/8XgZZY5bXHbiPhYdeUIQAIZUClQr8fr6lAHfsC8p
	 YmIiYyOM59d+gGgr6W1BIVoazQcHr+aHWM0EbMxEwCJ6rjc8SLxit1crRrrQYcudIK
	 OAqBw6hHU+GNg==
Date: Wed, 16 Sep 2026 03:35:28 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Triet Hoang <triet.hoang.dev@gmail.com>, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 4/8] watchdog: msc313e_wdt: Convert to
 DEFINE_SIMPLE_DEV_PM_OPS()
Message-ID: <aqoOgP8xeUx_uqWY@google.com>
References: <20260914085451.891675-1-triet.hoang.dev@gmail.com>
 <20260914085451.891675-5-triet.hoang.dev@gmail.com>
 <20260914092012.20B861F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914092012.20B861F000FF@smtp.kernel.org>

On Mon, Sep 14, 2026 at 09:20:11AM +0000, sashiko-bot@kernel.org wrote:
> > diff --git a/drivers/watchdog/msc313e_wdt.c b/drivers/watchdog/msc313e_wdt.c
> > index 4a5cce2a16b18..a77ff57a44571 100644
> > --- a/drivers/watchdog/msc313e_wdt.c
> > +++ b/drivers/watchdog/msc313e_wdt.c
> 
> [ ... ]
> 
> > -static int __maybe_unused msc313e_wdt_resume(struct device *dev)
> > +static int msc313e_wdt_resume(struct device *dev)
> >  {
> >  	struct msc313e_wdt_priv *priv = dev_get_drvdata(dev);
> >  
> >  	if (watchdog_active(&priv->wdev) || watchdog_hw_running(&priv->wdev))
> >  		msc313e_wdt_start(&priv->wdev);
> >  
> >  	return 0;
> 
> [Severity: High]
> This is a pre-existing issue, but does msc313e_wdt_resume() need to handle
> the return value of msc313e_wdt_start()?
> 
> If clk_prepare_enable() fails inside msc313e_wdt_start():
> 
> msc313e_wdt_start() {
> 	...
> 	err = clk_prepare_enable(priv->clk);
> 	if (err)
> 		return err;
> 	...
> }
> 
> The error is returned to msc313e_wdt_resume(), which discards it and returns
> 0. Because the watchdog core state still considers the hardware active,
> could subsequent operations like watchdog ping perform writes to unclocked
> hardware registers (such as REG_WDT_CLR) and trigger a bus fault or system
> crash?

https://lore.kernel.org/all/20260912163334.28636-1-tzungbi@kernel.org tries
to address the issue.
