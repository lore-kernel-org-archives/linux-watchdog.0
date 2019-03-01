Return-Path: <SRS0=BWH3=RE=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BC5C43381
	for <linux-watchdog@archiver.kernel.org>; Fri,  1 Mar 2019 22:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AF4C2083E
	for <linux-watchdog@archiver.kernel.org>; Fri,  1 Mar 2019 22:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHXd9TVs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfCAW20 (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Fri, 1 Mar 2019 17:28:26 -0500
Received: from mail-pl1-f182.google.com ([209.85.214.182]:36876 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfCAW2Z (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 1 Mar 2019 17:28:25 -0500
Received: by mail-pl1-f182.google.com with SMTP id q3so12130955pll.4
        for <linux-watchdog@vger.kernel.org>; Fri, 01 Mar 2019 14:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JJSp+PU7jWYu5uVkRi5sFWZ+JZ/gH+BmFQQ5V1cvlfU=;
        b=eHXd9TVsvjW+0waSRSjuldI05+ji3x5liByiGd90TPKKacE9tLQ85UbhTCCuF4yNcn
         PyEShkiYkMkIHrqET+tztBBCINCgQdTQ7jY0K4/K3kVqvNHDOf3hmoCpXWJPlc8jhyTj
         CCjgzBugV0QluaT5E1oqQ9uAWi5kBqTB+hV8ysKjER11ctUq9g4RQ2CL4uXs6Hf4T1WB
         2Ftd7ciAdmtMEIC0QubjQx2Evqi+CcaNzIokoSACEDcfF/DCsFj+ar7SB35RY8lh+Tm5
         r/G2Anjz1L9PGsvwWJm+o/DcCskDxmNA90HjgDTppvZ2gu4SGuuLsQCdLkTilv2ZuqJL
         trzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=JJSp+PU7jWYu5uVkRi5sFWZ+JZ/gH+BmFQQ5V1cvlfU=;
        b=GsY2y7FPdOj38Z+IyXf53sE3fI1xdVrWcB9JHlMQN0QoKwQR8uMPsmpW2TXB1Sd6mu
         KpYJdcXU4JSfY8yPYZFcxfOjzovZSH4dM8U9L0ZQeA3mHzp8XYtPaJGFe9AzrpIyuVCq
         1UR+0KhDwE7es/+qZ+M9Fy/w/vygGVjGCD3VbWkhatTDOBpbLL0lKpBmEN2kzO+1Qjt+
         TJ/w/nhgnOukaqpViGShWvannoF4uED9kPYwbg2bCEsNqewGkAOU9t02wn0liTXLBYBv
         cJx6d3nk4KWeql4ruUYtIsnBMdHcj03cW8+npFFRt2eV/V5cOM0G6F2TyqoV+fbZi6A7
         aKXw==
X-Gm-Message-State: APjAAAWQvQIlI5SV6RMdX17oSir89Tj11FWPkvJtHXphXh2TYQFAh0dg
        5PNM6T9oIZtXi3xnsgV9HHaQPz9T
X-Google-Smtp-Source: APXvYqxFmZN3aeweNk80uuRapUnRuf66SIMz2XkfVtnrIUROxEUaUblGqvzQgS5tGZsGL59zY/8YsA==
X-Received: by 2002:a17:902:ba8c:: with SMTP id k12mr8005107pls.193.1551479305231;
        Fri, 01 Mar 2019 14:28:25 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o76sm42040616pfa.156.2019.03.01.14.28.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 14:28:24 -0800 (PST)
Date:   Fri, 1 Mar 2019 14:28:23 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Konstantin Ryabitsev via RT 
        <kernel-helpdesk@rt.linuxfoundation.org>
Cc:     linux-watchdog@vger.kernel.org, wim@iguana.be
Subject: Re: [Kernel.org Helpdesk #69024] patchwork support for
 linux-watchdog@vger.kernel.org
Message-ID: <20190301222823.GB24192@roeck-us.net>
References: <RT-Ticket-69024@linuxfoundation>
 <4ae83727-d89e-5201-00bc-347b3a8cea0a@roeck-us.net>
 <rt-4.4.0-17522-1551476952-1887.69024-6-0@linuxfoundation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rt-4.4.0-17522-1551476952-1887.69024-6-0@linuxfoundation>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Fri, Mar 01, 2019 at 04:49:12PM -0500, Konstantin Ryabitsev via RT wrote:
> On 2019-02-23 11:59:29, linux@roeck-us.net wrote:
> > Hi,
> > 
> > would it be possible to add support for linux-watchdog@vger.kernel.org
> > to patchwork.kernel.org, with me (and possibly wim@iguana.be if he has
> > an account) as maintainer(s) ? My patchwork account username is groeck.
> 
> Project added and subscribed. There doesn't appear to be a user matching wim@iguana.be, so only user groeck is set as project admin.
> 

Thanks a lot, appreciate it.

Guenter
