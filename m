Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C442B409107;
	Mon, 29 Jun 2026 13:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782739481; cv=none; b=Ht1C686T/9rx7WBkf8/yLhnHzT45J8YHXSAiqAk9VbYwhXMibzBzz/YTkvffPmppRPgxdLkRUwkIk97En6XwRG7Ej1fh0q8h5tOKWobjFQUvVw9PrW8iM43JuIvm2gP29op8pkZJ9OirCU/FI+kfC4GK5TBTJmivhCbNdJy48zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782739481; c=relaxed/simple;
	bh=XI36Wcjd53W3LgP4u8oNkwxJECwlX+KH/rCKXjbfWuw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:Content-Type:
	 MIME-Version; b=auA0mXInoEcYomaafPx3rJMXzgD/U2qBdsdB0qlBukWgE57hO1R+vo4srwGXaokMlyqZuYxWlDTFvAK6jk/XtNw/qZ0B+mOMrKkjgjhWwx8J0WmQxQ9snjKzV32cj6THzeqbKrOK5NC5pjzHQ2aTymV3ZW1orGlvxZJGSy6FWT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=eBSggJwm; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=KCjLcoeB; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="eBSggJwm";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="KCjLcoeB"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gpn7T39mlz9tbV;
	Mon, 29 Jun 2026 15:24:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1782739477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=XI36Wcjd53W3LgP4u8oNkwxJECwlX+KH/rCKXjbfWuw=;
	b=eBSggJwme7Ioe48cM2xHIJDrn5PDsj5+Myx3lM0fXcJTQgEMbOqAqDisx8MSsd6vcx7zkC
	7g6aCldqNS7Scbmj1vViucuC0r0cCUj781RcSPk/WOT7Yc2lY0wMkyjRkqsBdqnBaok3AW
	cDv/J9adnWD3V7jQYIgFLGLaOVT7/SK9Tk9HDqnK/4VnNpw+fITjroUL8XLd7L0k2sRSaP
	RhrSpKB3JGa3uOY6fgbouhp9EtjMMACbOaJS1Yib2ecksfV3gDNMR3Q5HN/bG2vihYXY7t
	MmcPAvwvORbCCMbTEVSSoP/khK2lPCEteEWZvcdGxbYevVzJU6WDoo+GwJtB/w==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=KCjLcoeB;
	spf=pass (outgoing_mbo_mout: domain of manuelebner@mailbox.org designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=manuelebner@mailbox.org
Message-ID: <14d8a272b4d57b9e316a1351b38867417a2a6603.camel@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1782739475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=XI36Wcjd53W3LgP4u8oNkwxJECwlX+KH/rCKXjbfWuw=;
	b=KCjLcoeBzamkPvuUFAq/i85UZHssRz5nCHQ1TLNagQ8rPGo8dqGIFdDjSguJIFqssF5M2V
	6FjMkUJh/jXlGcOCVmcjOV4b8jSEHjIBoHLdZModz4oNVaCBsyfiEHcfRvM3rTTGCSnI9p
	TnrDxR4akHA89+ImM1j+zionOS9BRZ/Siw71Mesda2IFjGNmykz76E1UaRCzTqYyq3PwBN
	KMidS2+ZLZ1sKmNxwzw6NoDjJnA+/9HGq8l2i5dZiQKHuV9J6OYmqcHHBuZHqRcAESko6O
	4UoEvKm83w+c1+ZYlpQmqht6PpLYdSKuk6voo+0UCkGf8KGGUyztl9jQsWWEeA==
Subject: Re: [PATCH] docs: watchdog: Fix brackets
From: Manuel Ebner <manuelebner@mailbox.org>
To: rdunlap@infradead.org
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 	linux-watchdog@vger.kernel.org, linux@roeck-us.net,
 manuelebner@mailbox.org, 	skhan@linuxfoundation.org, wim@linux-watchdog.org
Date: Mon, 29 Jun 2026 15:24:30 +0200
In-Reply-To: <040f4089-7f81-470a-92d3-3ad022f3fd86@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: k8hdp4aqudafom9gmgrrdxdfcxz5fnf6
X-MBO-RS-ID: 10ce00d0ddb0fe443d4
X-Rspamd-Queue-Id: 4gpn7T39mlz9tbV

Hi,

is this patch on it's way?

Thanks
 Manuel
