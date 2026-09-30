Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573DA476067;
	Wed, 30 Sep 2026 11:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790769266; cv=none; b=Z0Mz3YGZ45A0CYbQRl/+RxbaV1hpF+82CrX40Wu9SVrb82uoXtePZN6v8FqnwU/sgAQrsm4Xj7o3axA3PIJnOUDqc4chIAB1zY6rlWZs2S3eVBWwexrzHWXvADnUPKYbn26MphSIFaDSgwnVOc696lDIHLlsZgcYWFqbifSpqj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790769266; c=relaxed/simple;
	bh=wvxno0g7TZW4Q3braNrSuHODYqDOK/dTTiMALk32864=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VdZkqOl66Mm00XHIrGZqKslpVJNBTBlUhPoqcxiwf0pYQkN6vGCoQJqHl0K7jh8d/JtXwmdUSHPf0/Y0b335Jt5mBkv31Bj/lb2ZID+/8CiQX8+87u8gxYj5hlW8ndxIzWJCsNdlKnFl2eqqD8/5wwTe/D07/N7GMBObjS97M7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUWdkK5A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUWdkK5A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D03C1F000FF;
	Wed, 30 Sep 2026 11:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790769263;
	bh=d4jVWHcBEBxU5slw0xE4b/V4y+snufIa7M9YTgvATXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MUWdkK5AFsGDo7UjMPybod6USBC4nqSAPuRDeN4CfstMlxG2opOUmnQMyHd8fPerR
	 m05Xpo6IHusPwPPpb89SusZh/suVkSjw3v8DrMMzRLlJnsOk7X1LZC+oSB55YjbT1E
	 LE4WWxOPLmcsI2ic3oV3JFxAPl6BKRgFIjV7c9nFhk5/D5U2IAUGJTp30bOnyQP6+a
	 /j0smIX4VsiACvie8JL5maNBtW2vIVtPnqm+i4c/xEK3iLCwVkwElicGMWIV359RzS
	 7alf/Ipps6bLz4/QryksaPdsRT1VS+l/J0wHx39JZCILgP+fUhz+H0pAjIRpFDHTqv
	 U7+ZrGzAhJeyw==
Date: Wed, 30 Sep 2026 19:54:20 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] watchdog: core: Restore WDOG_HW_RUNNING if stopping
 watchdog fails
Message-ID: <arz4bE9RRKSMQMrf@tzungbi-laptop>
References: <20260929134635.2567137-1-linux@roeck-us.net>
 <20260929134635.2567137-6-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929134635.2567137-6-linux@roeck-us.net>

On Tue, Sep 29, 2026 at 06:46:32AM -0700, Guenter Roeck wrote:
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index af756ee228b2..edf2cccd1c0e 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -324,6 +324,8 @@ static int watchdog_stop(struct watchdog_device *wdd)
>  		clear_bit(WDOG_ACTIVE, &wdd->status);
>  		watchdog_update_worker(wdd);
>  		watchdog_hrtimer_pretimeout_stop(wdd);
> +	} else {
> +		set_bit(WDOG_HW_RUNNING, &wdd->status);
>  	}

This makes more sense to me to move into the block introduced by [1].
E.g.,

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index e8c1fcb53c56..4a9c41480fb8 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -306,7 +306,12 @@ static int watchdog_stop(struct watchdog_device *wdd)
 	if (wdd->ops->stop) {
 		clear_bit(WDOG_HW_RUNNING, &wdd->status);
 		err = wdd->ops->stop(wdd);
-		if (err < 0) {
+		if (err == 0) {
+			clear_bit(WDOG_ACTIVE, &wdd->status);
+			watchdog_update_worker(wdd);
+			watchdog_hrtimer_pretimeout_stop(wdd);
+		} else {
+			set_bit(WDOG_HW_RUNNING, &wdd->status);
 			pr_err("watchdog%d: Failed to stop watchdog: %pe\n",
 			       wdd->id, ERR_PTR(err));
 		}
@@ -315,12 +320,6 @@ static int watchdog_stop(struct watchdog_device *wdd)
 		set_bit(WDOG_HW_RUNNING, &wdd->status);
 	}
 
-	if (err == 0) {
-		clear_bit(WDOG_ACTIVE, &wdd->status);
-		watchdog_update_worker(wdd);
-		watchdog_hrtimer_pretimeout_stop(wdd);
-	}
-
 	return err;
 }

[1] https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git/commit/?id=7b08904eb388d942fed86adf4f5edaaed554e814
